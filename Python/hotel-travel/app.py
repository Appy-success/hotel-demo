EXAMPLE_SEARCHES = [
    "pool",  # Find hotels with swimming pools
    "spa",  # Discover hotels with spa facilities
    "gym",  # Hotels with fitness centers
    "breakfast",  # Hotels offering breakfast
    "gaming",  # Hotels with casino or gaming facilities
    "restaurant",  # Hotels with dining options
    "luxury spa resort",  # High-end spa resorts
    "family pool hotel",  # Family hotels with pools
    "business downtown",  # Business hotels in city center
    "airport",  # Hotels near the airport
    "beach",  # Beachfront properties
    "4 star",  # Hotels with 4-star rating
    "renovated"  # Find recently renovated hotels
]
import os
import logging
from flask import Flask, request, render_template, redirect, url_for
from dotenv import load_dotenv

# Import search namespaces
from azure.core.credentials import AzureKeyCredential
from azure.search.documents import SearchClient
from azure.core.exceptions import AzureError


app = Flask(__name__)

# Configure logging
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)


# Load environment variables for Azure Search config only
load_dotenv()
search_endpoint = os.getenv('SEARCH_SERVICE_ENDPOINT')
search_key = os.getenv('SEARCH_SERVICE_QUERY_KEY')
search_index = os.getenv('SEARCH_INDEX_NAME')
search_indexer = os.getenv('SEARCH_INDEXER_NAME')
search_skillset = os.getenv('SEARCH_SKILLSET_NAME')

# Fail fast if any required config is missing
required_vars = [
    ("SEARCH_SERVICE_ENDPOINT", search_endpoint),
    ("SEARCH_SERVICE_QUERY_KEY", search_key),
    ("SEARCH_INDEX_NAME", search_index)
]
missing_vars = [var for var, val in required_vars if not val]
if missing_vars:
    raise RuntimeError(f"Missing required environment variables: {', '.join(missing_vars)}. Please set them in your .env file.")

# Wrapper function for request to search index with optimized hotel search
def search_query(search_text, filter_by=None, sort_order=None):
    try:
        # Create a search client with connection pooling
        azure_credential = AzureKeyCredential(search_key)
        search_client = SearchClient(search_endpoint, search_index, azure_credential)

        # Log the search request
        logger.info(f"Searching for: {search_text}")

        # Submit search query optimized for hotel data
        results = search_client.search(
            search_text,
            search_mode="any",
            include_total_count=True,
            filter=filter_by,
            order_by=sort_order,
            facets=['Category', 'Tags', 'Rating'],
            highlight_fields='HotelName,Description',
            select="HotelId,HotelName,Description,Category,Tags,ParkingIncluded,LastRenovationDate,Rating,Address,people,organizations,locations,keyphrases,masked_text",
            top=20
        )

        logger.info(f"Search returned {results.get_count()} results")
        return results

    except AzureError as azure_ex:
        logger.error(f"Azure Search error: {azure_ex}")
        raise azure_ex
    except Exception as ex:
        logger.error(f"Search error: {ex}")
        raise ex

# Home page route
@app.route("/")
def home():
    return render_template("default.html")

# Search results route optimized for hotel data
@app.route("/search", methods=['GET'])
def search():
    try:
        # Get the search terms from the request form
        search_text = request.args.get("search", "")
        
        if not search_text:
            return render_template("search.html", search_results=[], search_terms="", error="Please enter a search term", example_searches=EXAMPLE_SEARCHES)

        # If a facet is selected, use it in a filter
        filter_expression = None
        if 'facet' in request.args:
            facet_value = request.args["facet"]
            facet_type = request.args.get("facet_type", "Category")
            
            if facet_type == "Category":
                filter_expression = f"Category eq '{facet_value}'"
            elif facet_type == "Tags":
                filter_expression = f"Tags/any(t: t eq '{facet_value}')"
            elif facet_type == "Rating":
                filter_expression = f"Rating ge {facet_value}"

        # If a sort field is specified, modify the search expression accordingly
        sort_expression = None  # Default to relevance (search.score())
        sort_field = 'relevance'  # default sort is search.score(), which is relevance
        
        if 'sort' in request.args:
            sort_field = request.args["sort"]
            if sort_field == 'name':
                sort_expression = 'HotelName asc'
            elif sort_field == 'rating':
                sort_expression = 'Rating desc'
            elif sort_field == 'date':
                sort_expression = 'LastRenovationDate desc'
            elif sort_field == 'price':
                # This would require room data aggregation, simplified for now
                sort_expression = 'Rating desc'

        # submit the query and get the results
        results = search_query(search_text, filter_expression, sort_expression)

        # render the results
        return render_template("search.html", 
                 search_results=results, 
                 search_terms=search_text,
                 sort_field=sort_field,
                 example_searches=EXAMPLE_SEARCHES)

    except Exception as error:
        logger.error(f"Search route error: {error}")
        return render_template("error.html", error_message=str(error))

# Health check route
@app.route("/health")
def health_check():
    try:
        # Test search service connection
        azure_credential = AzureKeyCredential(search_key)
        search_client = SearchClient(search_endpoint, search_index, azure_credential)

        # Simple search to test connectivity
        search_client.search("*", top=1)
        return {"status": "healthy", "search_service": "connected"}, 200
    except Exception as e:
        logger.error(f"Health check failed: {e}")
        return {"status": "unhealthy", "error": str(e)}, 500

# Add error handlers
@app.errorhandler(404)
def not_found(error):
    return render_template("error.html", error_message="Page not found"), 404

@app.errorhandler(500)
def internal_error(error):
    logger.error(f"Internal server error: {error}")
    return render_template("error.html", error_message="Internal server error"), 500

if __name__ == "__main__":
    app.run(debug=True, host="0.0.0.0", port=5000)
