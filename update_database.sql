-- First, we need to create a storage bucket for car images
-- Go to Supabase Dashboard -> Storage -> Create bucket named 'car-images'

-- Drop existing table if needed (WARNING: This deletes all data)
-- DROP TABLE IF EXISTS public.cars CASCADE;

-- Create updated cars table with multiple image support
CREATE TABLE IF NOT EXISTS public.cars (
    id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    model VARCHAR(255) NOT NULL,
    image_urls TEXT[] NOT NULL,
    specs TEXT NOT NULL,
    price DECIMAL(15, 2) NOT NULL,
    status VARCHAR(20) DEFAULT 'available' CHECK (status IN ('available', 'sold')),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT TIMEZONE('utc', NOW()),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT TIMEZONE('utc', NOW())
);

-- Update existing data to use array format (if any exists)
UPDATE public.cars 
SET image_urls = ARRAY[image_url] 
WHERE image_urls IS NULL AND image_url IS NOT NULL;

-- Add comments
COMMENT ON TABLE public.cars IS 'Stores luxury car inventory for UGN AUTOS with multiple image support';
COMMENT ON COLUMN public.cars.id IS 'Unique identifier for each car';
COMMENT ON COLUMN public.cars.name IS 'Car brand/name (e.g., Mercedes-Benz)';
COMMENT ON COLUMN public.cars.model IS 'Car model (e.g., S-Class S580)';
COMMENT ON COLUMN public.cars.image_urls IS 'Array of image URLs (front, back, side, interior, roof)';
COMMENT ON COLUMN public.cars.specs IS 'Car specifications/features';
COMMENT ON COLUMN public.cars.price IS 'Selling price in Naira';
COMMENT ON COLUMN public.cars.status IS 'Availability status: available or sold';

-- Create indexes
DROP INDEX IF EXISTS idx_cars_status;
CREATE INDEX idx_cars_status ON public.cars(status);

DROP INDEX IF EXISTS idx_cars_created_at;
CREATE INDEX idx_cars_created_at ON public.cars(created_at DESC);

-- Update trigger
DROP TRIGGER IF EXISTS update_cars_updated_at ON public.cars;

CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = TIMEZONE('utc', NOW());
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER update_cars_updated_at
    BEFORE UPDATE ON public.cars
    FOR EACH ROW
    EXECUTE FUNCTION update_updated_at_column();

-- Enable RLS
ALTER TABLE public.cars ENABLE ROW LEVEL SECURITY;

-- Drop existing policies
DROP POLICY IF EXISTS "Public read access to cars" ON public.cars;
DROP POLICY IF EXISTS "Authenticated users can insert cars" ON public.cars;
DROP POLICY IF EXISTS "Authenticated users can update cars" ON public.cars;
DROP POLICY IF EXISTS "Authenticated users can delete cars" ON public.cars;

-- Create new policies
CREATE POLICY "Public read access to cars"
    ON public.cars
    FOR SELECT
    TO public
    USING (true);

CREATE POLICY "Authenticated users can insert cars"
    ON public.cars
    FOR INSERT
    TO authenticated
    WITH CHECK (true);

CREATE POLICY "Authenticated users can update cars"
    ON public.cars
    FOR UPDATE
    TO authenticated
    USING (true);

CREATE POLICY "Authenticated users can delete cars"
    ON public.cars
    FOR DELETE
    TO authenticated
    USING (true);

-- Grant permissions
GRANT USAGE ON SCHEMA public TO anon, authenticated;
GRANT SELECT ON public.cars TO anon;
GRANT ALL ON public.cars TO authenticated;
GRANT USAGE, SELECT ON ALL SEQUENCES IN SCHEMA public TO anon, authenticated;

-- Insert sample car with multiple images
INSERT INTO public.cars (name, model, image_urls, specs, price, status)
VALUES (
    'Mercedes-Benz',
    'S-Class S580',
    ARRAY[
        'https://images.unsplash.com/photo-1618843479313-40f8afb4b4d8?w=800',
        'https://images.unsplash.com/photo-1606664515524-ed2f786a0bd6?w=800',
        'https://images.unsplash.com/photo-1552519507-da3b142c6e3d?w=800',
        'https://images.unsplash.com/photo-1542362567-b07e54358753?w=800',
        'https://images.unsplash.com/photo-1617788138017-80ad40651399?w=800'
    ],
    '4.0L V8 Biturbo Engine, 496 HP, 9G-TRONIC Automatic, 4MATIC All-Wheel Drive, Premium Interior',
    150000000.00,
    'available'
) ON CONFLICT (id) DO NOTHING;