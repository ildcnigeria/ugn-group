-- STEP 1: Add new image_urls column to existing table
ALTER TABLE public.cars ADD COLUMN IF NOT EXISTS image_urls TEXT[];

-- STEP 2: Migrate existing data from image_url to image_urls
UPDATE public.cars 
SET image_urls = ARRAY[image_url] 
WHERE image_urls IS NULL AND image_url IS NOT NULL;

-- STEP 3: Verify the data migration (this will show you the results)
SELECT 
    id, 
    name, 
    model, 
    image_url, 
    image_urls, 
    price, 
    status 
FROM public.cars;

-- STEP 4: Create indexes if they don't exist
CREATE INDEX IF NOT EXISTS idx_cars_status ON public.cars(status);
CREATE INDEX IF NOT EXISTS idx_cars_created_at ON public.cars(created_at DESC);

-- STEP 5: Update trigger function
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = TIMEZONE('utc', NOW());
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- STEP 6: Recreate trigger
DROP TRIGGER IF EXISTS update_cars_updated_at ON public.cars;
CREATE TRIGGER update_cars_updated_at
    BEFORE UPDATE ON public.cars
    FOR EACH ROW
    EXECUTE FUNCTION update_updated_at_column();

-- STEP 7: Update comments
COMMENT ON TABLE public.cars IS 'Stores luxury car inventory for UGN AUTOS with multiple image support';
COMMENT ON COLUMN public.cars.image_urls IS 'Array of image URLs (front, back, side, interior, roof)';

-- SUCCESS! Your table now supports multiple images