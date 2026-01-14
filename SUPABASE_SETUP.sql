# SUPABASE SETUP INSTRUCTIONS

## Step 1: Create a New Admin User in Supabase

Go to your Supabase dashboard at https://supabase.com/dashboard and follow these steps:

1. Navigate to **Authentication** → **Users**
2. Click **"Add user"** → **"Create new user"**
3. Enter the admin email address (e.g., admin@ugnautos.com)
4. Enter a secure password
5. Set **"Auto Confirm User"** to ON
6. Click **"Create User"**

## Step 2: Run the SQL Commands in Supabase SQL Editor

Go to the **SQL Editor** in your Supabase dashboard and run each of the following SQL commands:

---

### 1. Enable UUID Extension (if not already enabled)
```sql
-- Enable UUID extension for generating unique IDs
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
```

### 2. Create the 'cars' Table
```sql
-- Create cars table to store vehicle inventory
CREATE TABLE IF NOT EXISTS public.cars (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    model VARCHAR(255) NOT NULL,
    image_url TEXT NOT NULL,
    specs TEXT NOT NULL,
    price DECIMAL(15, 2) NOT NULL,
    status VARCHAR(20) DEFAULT 'available' CHECK (status IN ('available', 'sold')),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT TIMEZONE('utc', NOW()),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT TIMEZONE('utc', NOW())
);
```

### 3. Add Comments to the Table
```sql
-- Add table and column comments for documentation
COMMENT ON TABLE public.cars IS 'Stores luxury car inventory for UGN AUTOS';
COMMENT ON COLUMN public.cars.id IS 'Unique identifier for each car';
COMMENT ON COLUMN public.cars.name IS 'Car brand/name (e.g., Mercedes-Benz)';
COMMENT ON COLUMN public.cars.model IS 'Car model (e.g., S-Class S580)';
COMMENT ON COLUMN public.cars.image_url IS 'URL to car image';
COMMENT ON COLUMN public.cars.specs IS 'Car specifications/features';
COMMENT ON COLUMN public.cars.price IS 'Selling price in Naira';
COMMENT ON COLUMN public.cars.status IS 'Availability status: available or sold';
COMMENT ON COLUMN public.cars.created_at IS 'Timestamp when car was added';
COMMENT ON COLUMN public.cars.updated_at IS 'Timestamp when car was last updated';
```

### 4. Create an Index on Status for Faster Queries
```sql
-- Create index on status column for better performance when filtering
CREATE INDEX IF NOT EXISTS idx_cars_status ON public.cars(status);
```

### 5. Create an Index on Created_at for Better Sorting
```sql
-- Create index on created_at for better performance when sorting
CREATE INDEX IF NOT EXISTS idx_cars_created_at ON public.cars(created_at DESC);
```

### 6. Add Updated_at Trigger
```sql
-- Create a function to automatically update the updated_at timestamp
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = TIMEZONE('utc', NOW());
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Create trigger to call the function before any update
CREATE TRIGGER update_cars_updated_at
    BEFORE UPDATE ON public.cars
    FOR EACH ROW
    EXECUTE FUNCTION update_updated_at_column();
```

### 7. Enable Row Level Security (RLS)
```sql
-- Enable Row Level Security for better security
ALTER TABLE public.cars ENABLE ROW LEVEL SECURITY;
```

### 8. Create RLS Policies for Public Read Access
```sql
-- Allow public read access to the cars table
-- This allows anyone to view the cars without authentication
CREATE POLICY "Public read access to cars"
    ON public.cars
    FOR SELECT
    TO public
    USING (true);

-- Allow authenticated users to insert new cars
-- This allows the admin to add new cars
CREATE POLICY "Authenticated users can insert cars"
    ON public.cars
    FOR INSERT
    TO authenticated
    WITH CHECK (true);

-- Allow authenticated users to update cars
-- This allows the admin to edit car information
CREATE POLICY "Authenticated users can update cars"
    ON public.cars
    FOR UPDATE
    TO authenticated
    USING (true);

-- Allow authenticated users to delete cars
-- This allows the admin to remove cars
CREATE POLICY "Authenticated users can delete cars"
    ON public.cars
    FOR DELETE
    TO authenticated
    USING (true);
```

### 9. Grant Necessary Permissions
```sql
-- Grant usage on schema
GRANT USAGE ON SCHEMA public TO anon, authenticated;

-- Grant select on cars table to public (anonymous users)
GRANT SELECT ON public.cars TO anon;

-- Grant all privileges on cars table to authenticated users
GRANT ALL ON public.cars TO authenticated;

-- Grant usage, select on sequences
GRANT USAGE, SELECT ON ALL SEQUENCES IN SCHEMA public TO anon, authenticated;
```

### 10. Verify the Table Structure
```sql
-- Check the table structure to ensure everything is set up correctly
SELECT 
    column_name,
    data_type,
    is_nullable,
    column_default
FROM information_schema.columns
WHERE table_name = 'cars'
ORDER BY ordinal_position;
```

---

## Step 3: Test Your Setup

After running all the SQL commands, you can test the setup:

1. **Insert a test car record:**
```sql
INSERT INTO public.cars (name, model, image_url, specs, price, status)
VALUES (
    'Mercedes-Benz',
    'S-Class S580',
    'https://images.unsplash.com/photo-1618843479313-40f8afb4b4d8?w=800',
    '4.0L V8 Biturbo Engine, 496 HP, 9G-TRONIC Automatic, 4MATIC All-Wheel Drive',
    150000000.00,
    'available'
);
```

2. **Query all cars:**
```sql
SELECT * FROM public.cars ORDER BY created_at DESC;
```

3. **Check the RLS policies:**
```sql
SELECT 
    schemaname,
    tablename,
    policyname,
    permissive,
    roles,
    cmd,
    qual,
    with_check
FROM pg_policies
WHERE tablename = 'cars';
```

---

## Step 4: Verify Your Website Connection

1. Open `index.html` in your browser
2. Navigate to `cars.html` to see the test car you just added
3. Try the admin login with the email and password you created in Step 1
4. Login to the dashboard and try adding/editing/deleting cars

---

## Important Notes

1. **Security**: Ensure your Supabase project URL and anon key are not exposed in public repositories
2. **Image URLs**: When adding cars, use direct image URLs. You can host images on:
   - Imgur
   - Cloudinary
   - AWS S3
   - Supabase Storage
3. **Admin User**: Keep your admin credentials secure. Consider using a strong password
4. **RLS Policies**: The current policies allow any authenticated user to modify cars. For production, you may want to restrict this to specific admin roles
5. **Database Backups**: Regularly backup your Supabase database to prevent data loss

---

## Troubleshooting

### Issue: Cannot login to admin dashboard
**Solution**: 
- Verify the admin user was created in Authentication → Users
- Make sure "Auto Confirm User" was enabled
- Check that the email and password are correct

### Issue: Cars not displaying on the website
**Solution**:
- Verify the SQL commands ran successfully in the SQL Editor
- Check the Supabase project URL and API key in your HTML files
- Ensure the RLS policies allow public read access
- Check browser console for any error messages

### Issue: Cannot add/edit/delete cars in dashboard
**Solution**:
- Verify the admin user is authenticated
- Check that RLS policies allow authenticated users to insert/update/delete
- Verify you're using the correct API keys

### Issue: Images not loading
**Solution**:
- Verify the image URLs are accessible publicly
- Check for CORS issues with image hosting
- Try opening the image URL directly in a browser

---

## Optional: Enhanced Security for Production

For production use, consider creating an admin role and restricting operations:

```sql
-- Create admin role
CREATE ROLE admin_role;

-- Grant admin role to your admin user
GRANT admin_role TO <your_admin_user_email>;

-- Modify RLS policies to only allow admin_role
DROP POLICY IF EXISTS "Authenticated users can insert cars" ON public.cars;
DROP POLICY IF EXISTS "Authenticated users can update cars" ON public.cars;
DROP POLICY IF EXISTS "Authenticated users can delete cars" ON public.cars;

CREATE POLICY "Admins can insert cars"
    ON public.cars
    FOR INSERT
    TO admin_role
    WITH CHECK (true);

CREATE POLICY "Admins can update cars"
    ON public.cars
    FOR UPDATE
    TO admin_role
    USING (true);

CREATE POLICY "Admins can delete cars"
    ON public.cars
    FOR DELETE
    TO admin_role
    USING (true);
```

---

That's it! Your Supabase backend is now ready for the UGN AUTOS website.