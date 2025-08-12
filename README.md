
# Azure Hotel Search Application - Quick Start (Windows)

## How to Run in VS Code (Windows)

1. **Open VS Code** and navigate to your project folder.
2. **Open a new terminal** in VS Code (PowerShell recommended).
3. **Create a virtual environment** (if not already created):
  ```powershell
  python -m venv venv
  ```
4. **Activate the virtual environment**:
  ```powershell
  .\venv\Scripts\Activate
  ```
  You should see `(venv)` at the start of your prompt.
5. **Install dependencies**:
  ```powershell
  pip install -r requirements.txt
  ```
6. **Configure environment variables**:
  - Create a `.env` file in the project root and fill in your Azure Search credentials:
    ```env
    SEARCH_SERVICE_ENDPOINT=your_search_endpoint
    SEARCH_SERVICE_QUERY_KEY=your_search_query_key
    SEARCH_INDEX_NAME=your_index_name
    SEARCH_INDEXER_NAME=your_indexer_name
    SEARCH_SKILLSET_NAME=your_skillset_name
    ```
  - **Important:** Do NOT commit your actual credentials to GitHub. Use placeholder values in `.env` and keep your real credentials private.
7. **Run the application**:
  ```powershell
  python Python/hotel-travel/app.py
  ```
  (App file path: `Python/hotel-travel/app.py`)

8. **Access the app**:
  - Open your browser and go to: `http://localhost:5000`
  - Health check: `http://localhost:5000/health`

## Example Search Scenarios

Try searching for these real-world scenarios:

- Hotels in New York with free Wi-Fi
- 4-star hotels near the airport
- Pet-friendly hotels in San Francisco
- Budget hotels under $100 per night
- Luxury hotels with spa services
- Hotels with family rooms and breakfast included
- Accessible hotels in downtown Chicago
- Hotels with ocean view in Miami
- Business hotels with conference facilities
- Recently renovated hotels in London

You can also combine amenities, location, and rating for more refined results.

## Deactivate Virtual Environment
When finished:
```powershell
deactivate
```

---
For troubleshooting and advanced configuration, see the full documentation in previous README versions.
