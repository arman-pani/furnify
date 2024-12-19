# Furnify : Furniture E-Commerce Mobile Application

Furnify offers a seamless shopping experience for purchasing furniture from local markets. With features like augmented reality visualization, interactive maps, user reviews, secure payments, and real-time order tracking, this app bridges the gap between buyers and local furniture vendors.

## Key Features

1. **Explore Local Furniture Stores**
   - View nearby furniture shops on an interactive map using **Google Maps API**.
   - Browse diverse product catalogs from local vendors.

2. **Intelligent Cart Management**
   - Add, edit, or remove items from your shopping cart.
   - Keep track of your desired products for a streamlined checkout process.

3. **Ratings & Reviews**
   - Make informed decisions by reading product reviews and ratings from other customers.
   - Share your own feedback post-purchase.

4. **Order Tracking**
   - Monitor your order's progress in real-time with regular status updates.
   - Stay informed with delivery notifications.

5. **Secure Payment Integration**
   - Process payments with confidence using **Razorpay** for secure transactions.
   - Multiple payment methods ensure convenience and flexibility.

6. **Augmented Reality (AR) Visualization**
   - Visualize furniture in your real-world environment before purchase.
   - Use the **Flutter ARCore** plugin to view 3D models of furniture in augmented reality, enabling better decision-making.

7. **Authentication with Firebase**
   - Users can sign-up and sign-in with their email and password.
   - They can also sign-up with their social accounts like **Google, Facebook or Twitter**.

## Tech Stack

- **Flutter**: Cross-platform framework for building a modern, responsive user interface.
- **Firebase**: Backend services for authentication, real-time database, and cloud storage.
- **SQLite**: Local database for favorites, cart data, order receipts, and user information.
- **Riverpod**: State management for scalable and maintainable application architecture.

## Other Services and Packages:

- **Google Maps API**: Provides an interactive map to locate nearby furniture shops.
- **Razorpay Payment Gateway**: Enables secure payment processing with multiple options.
- **ARCore Package**: Offers AR capabilities for visualizing furniture in real-world environments.

## Installation Instructions

**Prerequisites**
- Install Flutter and ensure the environment is set up.
- Set up a Firebase project and download the necessary configuration files.

**Steps**
1. **Clone the Repository**
   ```bash
   git clone https://github.com/your-repo/furniture-ecommerce-app.git
   cd furniture-ecommerce-app

2. **Install Dependencies**
   ```bash
   flutter pub get

3. **Set Up Firebase**
   - Add the google-services.json file for Android and GoogleService-Info.plist for iOS.
   - Configure Firebase Storage rules for secure access.

4. **Run the Application**
   ```bash
   flutter run

## Contribution Guidelines

We welcome contributions to enhance the application! To contribute:
1. Fork the repository.
2. Create a feature or bug-fix branch.
3. Submit a pull request with detailed descriptions of changes.
