#!/bin/bash

# TrueBlack API Test Script
# Tests all production endpoints

BASE_URL="https://trueblack-api-production.up.railway.app"

echo "🧪 Testing TrueBlack Production API..."
echo "========================================"
echo ""

# Test 1: REST API - Stores
echo "1️⃣  Testing REST API - Stores..."
STORES_RESPONSE=$(curl -s "$BASE_URL/api/v1/stores")
if echo "$STORES_RESPONSE" | grep -q '"id"'; then
    echo "   ✅ Stores API working"
    STORE_COUNT=$(echo "$STORES_RESPONSE" | python3 -c "import sys, json; print(len(json.load(sys.stdin)))" 2>/dev/null || echo "0")
    echo "   📊 Found $STORE_COUNT stores"
else
    echo "   ❌ Stores API failed"
    echo "   Response: $STORES_RESPONSE"
fi
echo ""

# Test 2: GraphQL API - Stores
echo "2️⃣  Testing GraphQL API - Stores..."
GRAPHQL_RESPONSE=$(curl -s "$BASE_URL/graphql" \
  -X POST \
  -H "Content-Type: application/json" \
  -d '{"query":"{ stores { id name } }"}')
if echo "$GRAPHQL_RESPONSE" | grep -q '"stores"'; then
    echo "   ✅ GraphQL API working"
else
    echo "   ❌ GraphQL API failed"
    echo "   Response: $GRAPHQL_RESPONSE"
fi
echo ""

# Test 3: GraphQL API - Menu Items
echo "3️⃣  Testing GraphQL API - Menu (Store ID 2)..."
MENU_RESPONSE=$(curl -s "$BASE_URL/graphql" \
  -X POST \
  -H "Content-Type: application/json" \
  -d '{"query":"{ stores(id: 2) { id name categories { id name menuItems { id name price imageUrl } } } }"}')
if echo "$MENU_RESPONSE" | grep -q '"menuItems"'; then
    echo "   ✅ Menu API working"
    ITEM_COUNT=$(echo "$MENU_RESPONSE" | python3 -c "import sys, json; data=json.load(sys.stdin); items=[item for store in data.get('data',{}).get('stores',[]) for cat in store.get('categories',[]) for item in cat.get('menuItems',[])]; print(len(items))" 2>/dev/null || echo "0")
    echo "   📊 Found $ITEM_COUNT menu items"
else
    echo "   ❌ Menu API failed"
    echo "   Response: $MENU_RESPONSE"
fi
echo ""

# Test 4: Marketplace Category
echo "4️⃣  Testing Marketplace Category..."
MARKETPLACE_RESPONSE=$(curl -s "$BASE_URL/graphql" \
  -X POST \
  -H "Content-Type: application/json" \
  -d '{"query":"{ stores { categories(name: \"Marketplace\") { id name menuItems { id name price } } } }"}')
if echo "$MARKETPLACE_RESPONSE" | grep -q '"Marketplace"'; then
    echo "   ✅ Marketplace API working"
else
    echo "   ❌ Marketplace API failed"
    echo "   Response: $MARKETPLACE_RESPONSE"
fi
echo ""

# Test 5: Admin API - List Stores
echo "5️⃣  Testing Admin API - List Stores..."
ADMIN_STORES=$(curl -s "$BASE_URL/api/v1/admin/stores")
if echo "$ADMIN_STORES" | grep -q '"id"'; then
    echo "   ✅ Admin Stores API working"
else
    echo "   ❌ Admin Stores API failed"
fi
echo ""

# Test 6: Admin API - List Menu Items
echo "6️⃣  Testing Admin API - List Menu Items..."
ADMIN_ITEMS=$(curl -s "$BASE_URL/api/v1/admin/menu_items")
if echo "$ADMIN_ITEMS" | grep -q '"id"'; then
    echo "   ✅ Admin Menu Items API working"
else
    echo "   ❌ Admin Menu Items API failed"
fi
echo ""

# Test 7: Health Check
echo "7️⃣  Testing Health Check..."
HEALTH=$(curl -s "$BASE_URL/up")
if echo "$HEALTH" | grep -q "ok"; then
    echo "   ✅ Health check passed"
else
    echo "   ❌ Health check failed"
fi
echo ""

echo "========================================"
echo "✅ API Testing Complete!"
echo ""
echo "📝 Summary:"
echo "   - REST API: Check above"
echo "   - GraphQL API: Check above"
echo "   - Admin API: Check above"
echo ""
echo "🔗 Useful URLs:"
echo "   - GraphiQL: $BASE_URL/graphiql"
echo "   - Health: $BASE_URL/up"
echo "   - Admin API Docs: See ADMIN_API.md"
