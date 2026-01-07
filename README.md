# 🌍 Idiomary
Unlock the world of expressions: Discover, translate, and save idioms across multiple languages.

Idiomary is a full-stack Ruby on Rails application fist mobile designed for language lovers and travelers. It uses AI-powered logic to help users find not just literal translations, but the true cultural equivalents of idioms across five major languages: English, Italian, French, Spanish, and Portuguese.

## ✨ Features
### 🔍 Smart Search
* **AI-Driven Translations**: Get literal meanings, cultural equivalents, and usage examples for any idiom.
* **Multi-Language Support**: Seamlessly translate between English 🇬🇧, Italian 🇮🇹, French 🇫🇷, Spanish 🇪🇸, and Portuguese 🇵🇹.
* **Dynamic Interface**: Real-time flag updates and interactive language selection for a smooth user experience.

### 📚 Personal Dictionary
* **Save for Later**: Authenticated users can save their favorite idioms into a personal digital dictionary.
* **Collection Management**: View and manage your saved idioms through a dedicated "My Dictionary" dashboard.
* **Context Preservation**: Saved idioms include the original phrase, the translation, and the AI-generated cultural context.

### 👤 User Experience
* **Secure Authentication**: Powered by Devise for safe account creation and personalized data storage.
* **Responsive Design**: A mobile-first approach with a custom-built UI, ensuring a premium experience on both smartphones and desktops.
* **Interactive Map UI**: A modern, clean interface featuring a dynamic map section and intuitive navigation.

## 🛠 Tech Stack
| Category | Technologies |
| :--- | :--- |
| **Framework** | Ruby on Rails 7 |
| **Database** | PostgreSQL |
| **Authentication** | Devise |
| **Frontend** | ERB, Custom CSS, JavaScript (Vanilla), Hotwire (Turbo) |
| **Icons** | FontAwesome 6 |
| **Translation** | AI Integration (OpenAI/Custom Logic) |

## 🗃 Database Architecture
The application follows a clean relational structure to manage user data and linguistic entries:

┌─────────────┐ │ Users │ ──┐ └─────────────┘ │ └──► SavedIdioms (My Dictionary) ├── original_phrase ├── translated_content ├── source_language └── target_language


**Key Models:**
* **User**: Handles authentication and manages the relationship with saved entries.
* **SavedIdiom**: Stores the idiomatic expressions, translations, and AI-generated metadata linked to a specific user.

## ⚙️ Installation & Setup
### 1. Clone the Repository
```bash
git clone [https://github.com/your-username/idiomary.git](https://github.com/your-username/idiomary.git)
cd idiomary
2. Install Dependencies
Bash

bundle install
3. Database Configuration
Bash

rails db:create
rails db:migrate
4. Configure Environment Variables
Create a .env file in the root directory and add your keys (e.g., for AI translation services):

AI_SERVICE_API_KEY=your_key_here
5. Start the Server
Bash

rails server
Visit: http://localhost:3000

🤝 Contributing
Fork the repository

Create a feature branch: git checkout -b feature/AmazingFeature

Commit your changes: git commit -m 'Add some AmazingFeature'

Push to the branch: git push origin feature/AmazingFeature

Open a Pull Request

📄 License
This project is open source and available under the MIT License.

📧 Contact
Sara Spadari
GitHub: @sarasp22
LinkedIn: sara-spadari

Idiomary - Break the ice in every language 🌍✨
