# Adding Marketplace Items to Production Database

## Problem
The MARKETPLACE category with 8 items (Coffee Scrub, Dune Mug, etc.) is missing from the production database.

## Solution Options

### Option 1: Run Migration (Recommended)
A migration file has been created: `db/migrate/20251122152234_add_marketplace_category.rb`

**Steps:**
1. Commit and push the migration to your repository:
   ```bash
   cd /Users/teja/Desktop/Backend/trueblack-api
   git add db/migrate/20251122152234_add_marketplace_category.rb
   git commit -m "Add marketplace category migration"
   git push
   ```

2. Railway will automatically detect the new migration and run it during deployment.

3. Or manually trigger on Railway dashboard:
   - Go to your Railway project
   - Open the service
   - Go to "Settings" → "Deploy"
   - The migration will run automatically on next deploy

### Option 2: Run Rake Task
A rake task has been created: `lib/tasks/marketplace.rake`

**Steps:**
1. Commit and push the rake task:
   ```bash
   cd /Users/teja/Desktop/Backend/trueblack-api
   git add lib/tasks/marketplace.rake
   git commit -m "Add marketplace rake task"
   git push
   ```

2. Run via Railway CLI (after logging in):
   ```bash
   railway login
   railway run rake db:add_marketplace
   ```

3. Or run via Railway dashboard shell:
   - Open Railway dashboard
   - Go to your service
   - Open shell/terminal
   - Run: `rake db:add_marketplace`

### Option 3: Manual SQL (Quick Fix)
If you have access to the Railway database console, you can run this SQL directly.

**Note:** This is more complex and error-prone. Use Option 1 or 2 instead.

## What Gets Added

The migration/task will add to ALL stores:
- **Category:** MARKETPLACE
- **8 Items:**
  1. Coffee Scrub - ₹550
  2. Dune Mug - ₹850
  3. Dune Cup - ₹650
  4. Kinto Tumbler Beige - ₹1,250
  5. Kinto Tumbler Steel - ₹1,450
  6. Moonlight Cup - ₹750
  7. True Mocha Soap - ₹350
  8. Valencia Orange Soap - ₹350

## Verification

After running the migration/task, verify with:
```bash
cd /Users/teja/Desktop/TrueBlackApp_working
node test_marketplace_api.js
```

You should see:
```
✅ MARKETPLACE category found!
   Items: 8
   - Coffee Scrub (₹550)
   - Dune Mug (₹850)
   ...
```

## Files Created
1. `/db/migrate/20251122152234_add_marketplace_category.rb` - Migration file
2. `/lib/tasks/marketplace.rake` - Rake task
3. This instruction file

## Next Steps
1. Choose Option 1 (migration) or Option 2 (rake task)
2. Commit and push the files
3. Deploy or run the task on Railway
4. Verify marketplace items appear in the app
