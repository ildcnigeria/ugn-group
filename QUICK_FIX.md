# QUICK FIX - Database Migration

## The Error:
The existing `cars` table doesn't have the `image_urls` column yet. We need to add it first.

## Solution:

### Step 1: Run Migration Script

1. Go to https://supabase.com/dashboard
2. Select your project
3. Go to **SQL Editor** (left sidebar)
4. Open file: `migrate_database.sql`
5. **Copy ALL** the SQL code
6. **Paste** into SQL Editor
7. Click **"Run"**

This will:
- Add the `image_urls` column to your existing table
- Migrate any existing data from `image_url` to `image_urls`
- Create indexes
- Update the trigger

### Step 2: Verify Migration Worked

After running the migration, you should see:
- **Success** message
- A table showing your existing cars
- Both `image_url` (old) and `image_urls` (new) columns

### Step 3: Create Storage Bucket

1. Go to **Storage** → **Buckets**
2. Click **"New bucket"**
3. Name: `car-images` (exactly this, lowercase)
4. Toggle **"Public bucket"** to **ON**
5. Click **"Create bucket"**

### Step 4: Set Storage Policies

#### Policy 1: Public Read Access
1. In `car-images` bucket → **Policies** tab
2. Click **"New Policy"**
3. Template: **"No restrictions"**
4. Name: `Public read access`
5. Operations: **SELECT** only
6. Roles: **anon** and **authenticated**
7. Click **"Save"**

#### Policy 2: Authenticated Upload
1. Click **"New Policy"**
2. Template: **"No restrictions"**
3. Name: `Authenticated users can upload`
4. Operations: **INSERT** only
5. Roles: **authenticated** only
6. Click **"Save"**

### Step 5: Clear Browser Cache

**CRITICAL STEP** - You MUST clear cache:

**Windows:**
1. Press **Ctrl + Shift + Delete**
2. Select "Cached images and files"
3. Time range: "All time"
4. Click **"Clear data"**

**Mac:**
1. Press **Cmd + Shift + Delete**
2. Select "Cached images and files"
3. Time range: "All time"
4. Click **"Clear data"**

**Or hard refresh:**
- Windows: **Ctrl + Shift + R**
- Mac: **Cmd + Shift + R**

### Step 6: Test Everything

#### Test Login:
1. Open `admin.html`
2. Enter email: `dreysonglobal@gmail.com`
3. Enter password
4. Click **"Sign In"**
5. Should redirect directly to dashboard

#### Test Upload:
1. In dashboard, click **"Add New Car"**
2. Fill in car details
3. Upload 5 images (Front, Back, Side, Interior, Roof)
4. Click **"Upload Car"**
5. Wait for progress to complete
6. Car should appear in table

#### Test Carousel:
1. Go to `cars.html`
2. Find a car with images
3. Use arrows to navigate through images
4. Click dots for direct navigation

---

## Troubleshooting:

### Still getting "column does not exist" error?
Run this simple command first:
```sql
SELECT * FROM information_schema.columns 
WHERE table_name = 'cars' 
AND table_schema = 'public';
```

This will show you what columns currently exist. If `image_urls` is NOT in the list, the migration didn't run.

### Images not uploading?
Check:
1. Bucket named `car-images` exists
2. Bucket is set to **Public**
3. Storage policies are set correctly
4. Browser console shows errors (F12)

### Edit/Delete still not working?
1. Clear cache again
2. Try incognito mode
3. Check browser console (F12) for errors

---

## After Success:

Your website is ready! You can now:
- ✅ Upload up to 5 images per car
- ✅ Customers can swipe through images on cars page
- ✅ Admin can add, edit, delete cars
- ✅ Login works without annoying popup
- ✅ WhatsApp integration works

---

**Ready to go!** 🚗✨