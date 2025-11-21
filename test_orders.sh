#!/bin/bash

API_URL="http://localhost:3000/api/v1"

echo "1. Creating an order..."
curl -X POST "$API_URL/orders" \
  -H "Content-Type: application/json" \
  -d '{
    "table_number": "5",
    "items": [
      {"menu_item_id": 80, "quantity": 1},
      {"menu_item_id": 81, "quantity": 2}
    ]
  }'
echo -e "\n"

echo "2. Listing orders..."
curl -X GET "$API_URL/orders?table_number=5"
echo -e "\n"
