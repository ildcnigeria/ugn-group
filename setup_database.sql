-- Enable UUID extension for generating unique IDs
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

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

-- Create index on status column for better performance when filtering
CREATE INDEX IF NOT EXISTS idx_cars_status ON public.cars(status);

-- Create index on created_at for better performance when sorting
CREATE INDEX IF NOT EXISTS idx_cars_created_at ON public.cars(created_at DESC);

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

-- Enable Row Level Security for better security
ALTER TABLE public.cars ENABLE ROW LEVEL SECURITY;

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

-- Grant usage on schema
GRANT USAGE ON SCHEMA public TO anon, authenticated;

-- Grant select on cars table to public (anonymous users)
GRANT SELECT ON public.cars TO anon;

-- Grant all privileges on cars table to authenticated users
GRANT ALL ON public.cars TO authenticated;

-- Grant usage, select on sequences
GRANT USAGE, SELECT ON ALL SEQUENCES IN SCHEMA public TO anon, authenticated;

-- Insert a sample car for testing
INSERT INTO public.cars (name, model, image_url, specs, price, status)
VALUES (
    'Mercedes-Benz',
    'S-Class S580',
    'https://images.unsplash.com/photo-1618843479313-40f8afb4b4d8?w=800',
    '4.0L V8 Biturbo Engine, 496 HP, 9G-TRONIC Automatic, 4MATIC All-Wheel Drive',
    150000000.00,
    'available'
);

-- Verify the table structure
SELECT 
    column_name,
    data_type,
    is_nullable,
    column_default
FROM information_schema.columns
WHERE table_name = 'cars'
ORDER BY ordinal_position;