# TrueBlack Admin API Documentation

## Overview
The TrueBlack Admin API provides endpoints for managing stores, categories, menu items, and sending push notifications to the mobile app.

**Base URL:** `https://trueblack-api-production.up.railway.app/api/v1/admin`

## Authentication
Currently, the admin API endpoints are open. In production, you should add authentication (JWT tokens, API keys, or basic auth).

---

## Endpoints

### 1. Stores Management

#### List all stores
```http
GET /api/v1/admin/stores
```

**Response:**
```json
[
  {
    "id": 1,
    "name": "Jubilee Hills",
    "space_name": "Modern Beige",
    "area": "Jubilee Hills",
    "address": "Road No. 36, Jubilee Hills, Hyderabad",
    "phone": "+91 98765 43211",
    "latitude": 17.4326,
    "longitude": 78.4071,
    "hours": "7:00 AM - 11:00 PM"
  }
]
```

#### Create a new store
```http
POST /api/v1/admin/stores
Content-Type: application/json

{
  "store": {
    "name": "Banjara Hills",
    "space_name": "Sunset Orange",
    "area": "Banjara Hills",
    "address": "Road No. 12, Banjara Hills, Hyderabad",
    "phone": "+91 98765 43215",
    "latitude": 17.4239,
    "longitude": 78.4738,
    "hours": "8:00 AM - 10:00 PM"
  }
}
```

**Response:** Returns the created store object with status `201 Created`

**Triggers:** Sends a push notification to all app users about the new store.

#### Update a store
```http
PATCH /api/v1/admin/stores/:id
Content-Type: application/json

{
  "store": {
    "hours": "7:00 AM - 12:00 AM"
  }
}
```

**Triggers:** Sends a push notification to all app users about the store update.

#### Delete a store
```http
DELETE /api/v1/admin/stores/:id
```

**Response:** `204 No Content`

---

### 2. Categories Management

#### List all categories
```http
GET /api/v1/admin/categories
```

**Response:**
```json
[
  {
    "id": 1,
    "name": "Coffee",
    "store_id": 1,
    "store": {
      "id": 1,
      "name": "Jubilee Hills"
    }
  }
]
```

#### Create a category
```http
POST /api/v1/admin/categories
Content-Type: application/json

{
  "category": {
    "name": "Desserts",
    "store_id": 1
  }
}
```

#### Update a category
```http
PATCH /api/v1/admin/categories/:id
Content-Type: application/json

{
  "category": {
    "name": "Hot Beverages"
  }
}
```

#### Delete a category
```http
DELETE /api/v1/admin/categories/:id
```

---

### 3. Menu Items Management

#### List all menu items
```http
GET /api/v1/admin/menu_items
```

**Response:**
```json
[
  {
    "id": 1,
    "name": "Cappuccino",
    "price": 150.0,
    "description": "Classic Italian coffee",
    "is_available": true,
    "is_veg": true,
    "image_url": "https://example.com/cappuccino.jpg",
    "category_id": 1,
    "category": {
      "id": 1,
      "name": "Coffee",
      "store": {
        "id": 1,
        "name": "Jubilee Hills"
      }
    }
  }
]
```

#### Create a menu item
```http
POST /api/v1/admin/menu_items
Content-Type: application/json

{
  "menu_item": {
    "name": "Chocolate Brownie",
    "price": 120.0,
    "description": "Rich chocolate brownie with vanilla ice cream",
    "category_id": 5,
    "is_available": true,
    "is_veg": true,
    "image_url": "https://example.com/brownie.jpg"
  }
}
```

**Triggers:** Sends a push notification to all app users about the new menu item.

#### Update a menu item
```http
PATCH /api/v1/admin/menu_items/:id
Content-Type: application/json

{
  "menu_item": {
    "price": 130.0,
    "is_available": false
  }
}
```

**Triggers:** Sends a push notification to all app users about the menu item update.

#### Delete a menu item
```http
DELETE /api/v1/admin/menu_items/:id
```

---

### 4. Push Notifications

#### Send a custom push notification
```http
POST /api/v1/admin/notifications/send
Content-Type: application/json

{
  "title": "Weekend Special!",
  "body": "Get 20% off on all beverages this weekend!",
  "data": {
    "type": "promotion",
    "discount": "20%"
  }
}
```

**Response:**
```json
{
  "message": "Notification sent successfully"
}
```

**Note:** This sends a notification to all users subscribed to the `/topics/all` FCM topic.

---

## Push Notification Setup

### Backend Configuration
1. Set the `FCM_SERVER_KEY` environment variable in Railway:
   ```bash
   FCM_SERVER_KEY=your_firebase_server_key
   ```

2. Get your Firebase Server Key from:
   - Firebase Console → Project Settings → Cloud Messaging → Server Key

### Mobile App Configuration
The React Native app should subscribe to the `all` topic on startup:

```javascript
import messaging from '@react-native-firebase/messaging';

// On app initialization
async function initFCM() {
  const token = await messaging().getToken();
  await messaging().subscribeToTopic('all');
  console.log('Subscribed to notifications');
}
```

---

## Building a Web Admin Panel

You can build a simple web admin panel using:

### Option 1: React Admin
```bash
npx create-react-app trueblack-admin
cd trueblack-admin
npm install react-admin ra-data-simple-rest
```

### Option 2: Simple HTML/JavaScript
Create an `admin.html` file that makes fetch requests to these endpoints.

### Option 3: Postman/Insomnia
Use API clients like Postman or Insomnia to manage the data directly.

---

## Example: Using cURL

### Create a new menu item
```bash
curl -X POST https://trueblack-api-production.up.railway.app/api/v1/admin/menu_items \
  -H "Content-Type: application/json" \
  -d '{
    "menu_item": {
      "name": "Iced Latte",
      "price": 140.0,
      "description": "Refreshing iced coffee with milk",
      "category_id": 1,
      "is_available": true,
      "is_veg": true,
      "image_url": "https://example.com/iced-latte.jpg"
    }
  }'
```

### Send a push notification
```bash
curl -X POST https://trueblack-api-production.up.railway.app/api/v1/admin/notifications/send \
  -H "Content-Type: application/json" \
  -d '{
    "title": "New Item Alert!",
    "body": "Try our new Iced Latte - now available!",
    "data": {
      "type": "new_item",
      "item_id": "123"
    }
  }'
```

---

## Next Steps

1. **Add Authentication:** Implement JWT or API key authentication for admin endpoints
2. **Build Web UI:** Create a React/Vue admin dashboard
3. **Image Upload:** Add image upload functionality using ActiveStorage + S3
4. **Analytics:** Track which notifications get the most engagement
5. **Scheduling:** Add ability to schedule notifications for later

---

## Error Handling

All endpoints return standard HTTP status codes:
- `200 OK` - Successful GET/PATCH/PUT
- `201 Created` - Successful POST
- `204 No Content` - Successful DELETE
- `422 Unprocessable Entity` - Validation errors
- `404 Not Found` - Resource not found
- `500 Internal Server Error` - Server error

Validation errors return:
```json
{
  "errors": {
    "name": ["can't be blank"],
    "price": ["must be greater than 0"]
  }
}
```
