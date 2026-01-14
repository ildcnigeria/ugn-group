# COMPLETE SETUP GUIDE FOR UGN AUTOS WEBSITE

## STEP 1: UPDATE SUPABASE DATABASE

### Run the SQL Commands

1. Go to your Supabase dashboard: https://supabase.com/dashboard
2. Select your project
3. Go to **SQL Editor** (left sidebar)
4. Open the file `update_database.sql` in this folder
5. **Copy ALL** the SQL code from that file
6. **Paste it** into the Supabase SQL Editor
7. Click **"Run"** to execute

This will:
- Update the cars table to support multiple images
- Create proper indexes
- Set up RLS policies
- Insert a sample car with 5 images

---

## STEP 2: CREATE STORAGE BUCKET FOR IMAGES

### Create the bucket:

1. Go to **Storage** → **Buckets** (in left sidebar)
2. Click **"New bucket"**
3. Enter bucket name: `car-images`
4. Click **"Create bucket"**

### Set bucket to public:

1. Click on the `car-images` bucket
2. Go to **Configuration** tab
3. Find **"Public bucket"**
4. Toggle it to **ON**
5. Click **"Save"**

---

## STEP 3: CONFIGURE STORAGE POLICIES

You need to set up policies to allow image uploads:

### Create Policy for Public Read Access:

1. In the `car-images` bucket, go to **Policies** tab
2. Click **"New Policy"**
3. Select **"Get started quickly"**
4. Policy template: **"No restrictions"**
5. Policy name: `Public read access`
6. Allowed operations: **SELECT** (check only SELECT)
7. Target roles: **anon** and **authenticated**
8. Click **"Review"** → **"Save policy"**

### Create Policy for Authenticated Upload:

1. Click **"New Policy"**
2. Policy template: **"No restrictions"**
3. Policy name: `Authenticated users can upload`
4. Allowed operations: **INSERT** (check only INSERT)
5. Target roles: **authenticated**
6. Click **"Review"** → **"Save policy"**

---

## STEP 4: CREATE ADMIN USER

1. Go to **Authentication** → **Users** (left sidebar)
2. Click **"Add user"** → **"Create new user"**
3. Enter:
   - Email: `dreysonglobal@gmail.com` (or your desired admin email)
   - Password: Create a strong password
4. Enable **"Auto Confirm User"** (important!)
5. Click **"Create User"**

---

## STEP 5: TEST THE WEBSITE

### Clear Browser Cache (IMPORTANT!)

Before testing, you MUST clear your cache:

**Windows/Linux:**
- Press **Ctrl + Shift + Delete**
- Select "Cached images and files"
- Click "Clear data"

**Mac:**
- Press **Cmd + Shift + Delete**
- Select "Cached images and files"
- Click "Clear data"

**OR Hard Refresh:**
- Windows: Press **Ctrl + Shift + R**
- Mac: Press **Cmd + Shift + R**

### Test Login:

1. Open `admin.html` in your browser
2. Enter your admin email and password
3. Click **"Sign In"**
4. Should redirect directly to dashboard (no popup notification)

### Test Image Upload:

1. In the dashboard, click **"Add New Car"**
2. Fill in car details:
   - Car Name: e.g., Mercedes-Benz
   - Model: e.g., S-Class S580
   - Upload 5 images (Front, Back, Side, Interior, Roof)
   - Specifications: e.g., 4.0L V8 Engine...
   - Price: e.g., 150000000
   - Status: Available
3. Click **"Upload Car"**
4. Wait for images to upload (progress indicator will show)
5. Car should appear in the table after successful upload

### Test Image Carousel on Cars Page:

1. Go to `cars.html`
2. Find a car with multiple images
3. Use the **left/right arrows** to navigate through images
4. Or click the **dots** at the bottom
5. Images should fade smoothly between each view

### Test WhatsApp Buy Button:

1. Click **"Buy Now"** on any car
2. WhatsApp should open with pre-filled message including:
   - Car name
   - Price
   - Specifications
3. Verify the WhatsApp number is correct: +234 810 908 3420

---

## TROUBLESHOOTING

### Issue: Images not uploading

**Solution:**
- Check if `car-images` bucket exists
- Verify bucket is set to **Public**
- Confirm storage policies are set correctly
- Check browser console for errors (F12)

### Issue: Cars not showing on website

**Solution:**
- Verify database was updated with `update_database.sql`
- Check if there's data in the cars table
- Run this query in SQL Editor to check:
  ```sql
  SELECT * FROM cars;
  ```

### Issue: Cannot login

**Solution:**
- Verify user exists in Authentication → Users
- Make sure "Auto Confirm User" was enabled
- Check email and password are correct
- Clear browser cache and try again

### Issue: "Storage bucket not found" error

**Solution:**
- Go to Storage → Buckets
- Create bucket named exactly: `car-images` (lowercase, hyphen)
- Make sure it's set to Public

### Issue: Sample car still showing old format

**Solution:**
- Run the `update_database.sql` again
- This will update the table schema
- Existing data will be migrated to new format

### Issue: Edit/Delete buttons not working

**Solution:**
- Clear browser cache (most common issue)
- Refresh dashboard page
- Check browser console for errors (F12)

---

## WHAT'S NEW IN THIS UPDATE

### 1. Image Upload System
- No more image URLs
- Direct image upload to Supabase Storage
- Automatic URL generation

### 2. Multiple Images Per Car
- Each car can have 5 images:
  - Front view
  - Back view
  - Side view
  - Interior view
  - Roof view

### 3. Image Carousel on Car Page
- Left/right navigation arrows
- Dot indicators for direct navigation
- Smooth fade transitions between images

### 4. Removed Login Popup
- Direct redirect to dashboard after login
- No annoying alert messages

### 5. Fixed JavaScript Errors
- Proper null checking for all elements
- Better error handling
- Console logging for debugging

### 6. Better Error Messages
- Clear feedback when uploads fail
- Helpful error messages for storage issues
- Progress indicators for image uploads

---

## IMAGE REQUIREMENTS

When uploading car images:

- **Format**: JPG, PNG, WEBP
- **Size**: Under 5MB per image
- **Quality**: High resolution recommended (at least 1920x1080)
- **Number**: Exactly 5 images required

---

## WHATSAPP NUMBERS CONFIGURED

- **Customer Inquiries**: +234 810 908 3420
  - Buy Now button
  - Call Us button
  - WhatsApp Us button

- **Sales Notifications**: +234 803 626 6161
  - Admin sales notification popup
  - Only when marking car as "Sold"

---

## SECURITY NOTES

1. **Keep admin credentials secure**
   - Use a strong, unique password
   - Don't share credentials

2. **Storage access**
   - Only authenticated users can upload
   - Public can view images
   - Prevents unauthorized uploads

3. **Database access**
   - RLS policies protect data
   - Public can read (view cars)
   - Authenticated can modify (admin only)

---

## NEXT STEPS AFTER SETUP

1. ✅ Add your first real car via dashboard
2. ✅ Test all 5 images upload
3. ✅ Verify carousel works on cars page
4. ✅ Test WhatsApp buy button
5. ✅ Try editing a car
6. ✅ Try deleting a car
7. ✅ Mark a car as sold (test WhatsApp notification)

---

## NEED HELP?

If you encounter any issues:

1. **Check browser console** (F12) for error messages
2. **Review Supabase logs** in your dashboard
3. **Verify all setup steps** were completed
4. **Clear browser cache** completely
5. **Try incognito mode** to rule out cache issues

---

**UGN AUTOS** - Luxury Redefined