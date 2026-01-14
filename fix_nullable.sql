-- FIX: Make image_url column nullable so we can use image_urls instead

-- Step 1: Make image_url column nullable
ALTER TABLE public.cars ALTER COLUMN image_url DROP NOT NULL;

-- Step 2: Verify the change
SELECT 
    column_name, 
    is_nullable, 
    data_type 
FROM information_schema.columns 
WHERE table_name = 'cars' 
AND table_schema = 'public'
ORDER BY ordinal_position;

-- Step 3: Check existing data
SELECT 
    id, 
    name, 
    model, 
    image_url, 
    image_urls, 
    price, 
    status 
FROM public.cars;

-- SUCCESS! Now image_url is optional and won't block new car inserts