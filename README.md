# UGN AUTOS - Luxury Car Dealership Website

A fully functional, luxurious car sales website built with HTML, CSS, and JavaScript, powered by Supabase for backend functionality.

## Features

### Public Features
- **Home Page**: Beautiful hero carousel with 10 luxurious car images that auto-rotate
- **About Us Page**: Company information, core values, and office locations with Google Maps integration
- **Our Cars Page**: Dynamic car inventory with search functionality by brand
- **WhatsApp Integration**: "Buy Now" button that opens WhatsApp chat with car details
- **Call Us & WhatsApp Buttons**: Quick access to contact the dealership
- **Luxurious Design**: Premium dark theme with gold accents, elegant typography, and smooth animations
- **Responsive Design**: Fully responsive on desktop, tablet, and mobile devices

### Admin Features
- **Secure Login**: Admin authentication using Supabase Auth
- **Admin Dashboard**: Comprehensive dashboard with inventory statistics
- **Add Cars**: Upload new cars with name, model, image URL, specs, price, and status
- **Edit Cars**: Update existing car information
- **Delete Cars**: Remove cars from inventory
- **Status Management**: Track cars as "Available" or "Sold"
- **Sales Notification**: WhatsApp popup when marking a car as sold to send sales details
- **Real-time Updates**: Changes reflect immediately on the public website

## Office Locations

### Head Office
2 Kabiru A. Yusuf Street, Beside Anan House, Mabushi District, Abuja

### Branch Office
Jinifa Plaza Plot 1014, Samuel Ademulegun Street, Central Business District

Both locations include "Get Directions" buttons that open Google Maps.

## Project Structure

```
ugn autos/
├── index.html              # Home page with carousel
├── about.html              # About us page
├── cars.html               # Car inventory page
├── admin.html              # Admin login page
├── dashboard.html          # Admin dashboard
├── styles.css              # All styling
├── js/
│   ├── app.js             # Navigation and global JS
│   └── carousel.js        # Hero carousel functionality
├── SUPABASE_SETUP.sql      # Supabase SQL setup instructions
└── README.md              # This file
```

## Setup Instructions

### Prerequisites
- A web browser (Chrome, Firefox, Safari, or Edge)
- A Supabase account (free tier works)
- Basic understanding of running HTML files

### Step 1: Create Supabase Project

1. Go to [supabase.com](https://supabase.com) and sign up/login
2. Create a new project named "UGN AUTOS"
3. Wait for the project to be set up (2-3 minutes)
4. Get your project URL and anon key from **Project Settings** → **API**

### Step 2: Setup Supabase Database

1. Go to your Supabase SQL Editor
2. Open `setup_database.sql` file
3. Copy all the SQL code (everything from the file)
4. Paste it into the Supabase SQL Editor
5. Click "Run" to execute all commands
6. Create an admin user in Authentication → Users:
   - Go to Authentication → Users
   - Click "Add user" → "Create new user"
   - Enter admin email (e.g., admin@ugnautos.com)
   - Enter a secure password
   - Enable "Auto Confirm User"
   - Click "Create User"

### Step 3: Update Configuration

The website is pre-configured with your Supabase credentials:
- **Project URL**: `https://enkscdyeuqnedjhawtpi.supabase.co`
- **Anon Key**: `sb_publishable_FzSikLnXtnXnQphBW4jGDQ_1zmH_Xx0`

If you need to update these, find and replace in all HTML files:
```javascript
const SUPABASE_URL = 'your_project_url';
const SUPABASE_ANON_KEY = 'your_anon_key';
```

### Step 4: Run the Website

Simply open `index.html` in your web browser. No build process or server required!

For a better experience, use a local development server:
```bash
# Using Python 3
python -m http.server 8000

# Using Node.js (with http-server installed)
npx http-server

# Using PHP
php -S localhost:8000
```

Then visit `http://localhost:8000` in your browser.

## Usage Guide

### For Admin

1. **Login**: Go to `admin.html` and login with your admin credentials
2. **Add a Car**:
   - Click "Add New Car" in the dashboard
   - Fill in the car details (name, model, image URL, specs, price, status)
   - Click "Upload Car"
3. **Edit a Car**: Click the edit icon on any car row
4. **Delete a Car**: Click the delete icon on any car row (confirm in popup)
5. **Mark as Sold**: Change status to "Sold" - a WhatsApp popup will appear to send sales details

### For Visitors

1. **Browse Cars**: Go to "Our Cars" page to see all available vehicles
2. **Search**: Use the search bar to find cars by brand, model, or specs
3. **Buy a Car**: Click "Buy Now" to open WhatsApp with the car details pre-filled
4. **Contact Us**: Use the Call Us or WhatsApp buttons in the navigation

## Image Hosting

When adding cars, you need to provide direct image URLs. Here are some options:

### Option 1: Use Unsplash (Free)
- Visit [unsplash.com](https://unsplash.com)
- Find luxury car images
- Right-click and "Copy image link"
- Paste into the image URL field

### Option 2: Use Cloudinary (Recommended for Production)
1. Create a free account at [cloudinary.com](https://cloudinary.com)
2. Upload your images
3. Get the delivery URL
4. Use the URL in the admin dashboard

### Option 3: Use Supabase Storage
1. Go to your Supabase project
2. Navigate to Storage → Create a new bucket named "cars"
3. Upload images to the bucket
4. Get the public URL for each image

### Option 4: Use Imgur
1. Create an account at [imgur.com](https://imgur.com)
2. Upload images
3. Get the direct link (not the page URL)

## WhatsApp Numbers

- **Customer Inquiries**: +234 810 908 3420
  - Used when customers click "Buy Now"
  - Call Us and WhatsApp Us buttons

- **Sales Notifications**: +234 803 626 6161
  - Used when admin marks a car as sold
  - Sends sales details to this number

## Customization

### Change Contact Information

Find and replace in all HTML files:
```html
<!-- WhatsApp Number -->
<a href="https://wa.me/2348109083420">...</a>

<!-- Phone Number -->
<a href="tel:+2348109083420">...</a>
```

### Change Colors

In `styles.css`, update the CSS variables:
```css
:root {
    --primary: #1a1a1a;      /* Main dark color */
    --secondary: #2c2c2c;    /* Secondary dark color */
    --accent: #c9a227;       /* Gold/brand color */
    --accent-light: #d4af37; /* Light gold */
    /* ... more colors */
}
```

### Change Carousel Images

In `index.html`, update the carousel slides:
```html
<div class="carousel-slide" style="background-image: url('your_image_url')"></div>
```

### Change Office Addresses

In `about.html`, update the location cards and Google Maps URLs.

## Troubleshooting

### Cars not displaying
- Check Supabase connection in browser console
- Verify database has records
- Check RLS policies allow public read access

### Cannot login to admin
- Verify admin user exists in Supabase Auth
- Check email and password
- Ensure "Auto Confirm User" is enabled

### Images not loading
- Verify image URLs are accessible
- Check for CORS issues
- Test opening image URL directly in browser

### Carousel not working
- Check browser console for JavaScript errors
- Ensure `js/carousel.js` is loaded
- Verify all carousel slides have background images

## Deployment Options

### Option 1: Netlify (Free)
1. Install Netlify CLI: `npm install -g netlify-cli`
2. Run: `netlify deploy` in the project directory
3. Follow the prompts

### Option 2: Vercel (Free)
1. Install Vercel CLI: `npm install -g vercel`
2. Run: `vercel` in the project directory
3. Follow the prompts

### Option 3: GitHub Pages (Free)
1. Create a GitHub repository
2. Push the project files
3. Go to Settings → Pages
4. Enable GitHub Pages

### Option 4: Traditional Hosting
Upload all files to any web hosting service (Bluehost, HostGator, GoDaddy, etc.)

## Security Notes

- The admin password is managed by Supabase Auth
- Use a strong, unique password for the admin account
- Enable two-factor authentication (2FA) for your Supabase account
- For production, consider restricting RLS policies to admin roles only
- Never commit sensitive credentials to public repositories

## Performance Tips

- Use optimized images (compress before uploading)
- Implement lazy loading for car images
- Consider using a CDN for static assets
- Enable compression on your hosting server

## Browser Support

- Chrome (latest)
- Firefox (latest)
- Safari (latest)
- Edge (latest)
- Mobile browsers (iOS Safari, Chrome Mobile)

## License

This project is built for UGN AUTOS. All rights reserved.

## Support

For issues or questions, please contact:
- Phone: +234 810 908 3420
- WhatsApp: +234 810 908 3420

## Credits

- Built with HTML, CSS, JavaScript
- Powered by Supabase
- Icons: Font Awesome
- Fonts: Playfair Display & Montserrat (Google Fonts)
- Images: Unsplash (for demo purposes)

---

**UGN AUTOS** - Luxury Redefined