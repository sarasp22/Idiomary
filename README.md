# 🌍 Idiomary

**Unlock the world of expressions: Discover, translate, and save idioms across multiple languages.**

🌐 **Live Demo:** [idiomary.up.railway.app](https://idiomary.up.railway.app)

---

## 📖 Overview

**Idiomary** is a mobile-first, full-stack **Ruby on Rails 7** application designed for language lovers, students, and travelers. Powered by **Google Gemini AI**, it helps users discover not just literal word-for-word translations, but the true **cultural equivalents**, meanings, and real-world usage examples of idioms across five major languages:

- 🇬🇧 **English**
- 🇮🇹 **Italian**
- 🇫🇷 **French**
- 🇪🇸 **Spanish**
- 🇵🇹 **Portuguese**

---

## ✨ Key Features

### 🔍 Smart AI Idiom Search
- **AI-Driven Cultural Translations**: Get the literal translation, natural cultural equivalent, contextual explanation, and example sentences in both the source and target languages.
- **5-Language Support**: Seamlessly translate between English, Italian, French, Spanish, and Portuguese.
- **Localized Interface (`I18n`)**: Switch the entire application UI and AI explanation language dynamically with real-time flag selectors.

### 📚 Personal Dictionary ("My Dictionary")
- **Save for Later**: Authenticated users can bookmark their favorite idioms into a personal digital dictionary.
- **Collection Management**: Browse, expand, and remove saved idiom cards from a dedicated dashboard.
- **Rich Context Preservation**: Each saved card retains the original expression, language pair flags, and full AI-generated breakdown.

### 👤 User Experience & Security
- **Authentication with Devise**: Secure sign-up, login, password management, and account settings.
- **Responsive Mobile-First UI**: Custom-crafted interface with a bottom navigation bar on mobile devices and an adaptive grid layout on desktop.

---

## 🛠 Tech Stack

| Category | Technologies |
| :--- | :--- |
| **Framework** | Ruby on Rails 7.1 (Ruby 3.3.5) |
| **Database** | PostgreSQL |
| **Authentication** | Devise |
| **Frontend** | ERB, Custom CSS, Vanilla JavaScript, Hotwire (Turbo & Stimulus) |
| **AI Integration** | Google Gemini API (`HTTParty` / `RubyLLM`) |
| **Icons & Typography** | FontAwesome 6, Google Fonts (Inter) |
| **Deployment** | Docker & Railway |

---

## 🗃 Database Architecture

```text
┌──────────────────────┐       1 : N       ┌──────────────────────────┐
│        Users         │ ────────────────► │    SavedTranslations     │
├──────────────────────┤                   ├──────────────────────────┤
│ id (PK)              │                   │ id (PK)                  │
│ email                │                   │ user_id (FK)             │
│ encrypted_password   │                   │ original_idiom           │
│ created_at           │                   │ source_language          │
│ updated_at           │                   │ target_language          │
└──────────────────────┘                   │ ai_response              │
                                           │ created_at / updated_at  │
                                           └──────────────────────────┘
```

---

## ⚙️ Local Installation & Setup

### 1. Clone the Repository
```bash
git clone https://github.com/sarasp22/idiomary.git
cd idiomary
```

### 2. Install Dependencies
```bash
bundle install
```

### 3. Configure Database
```bash
bin/rails db:create
bin/rails db:migrate
```

### 4. Configure Environment & Credentials
Set your Google Gemini API key via Rails encrypted credentials (`config/credentials.yml.enc`) or environment variables:
```bash
export GEMINI_API_KEY="your_gemini_api_key_here"
```

### 5. Run the Development Server
```bash
bin/rails server
```
Visit `http://localhost:3000` in your browser.

---

## 🚀 Deployment on Railway

Idiomary is containerized with Docker and deployed on **[Railway](https://railway.app/)**.

1. **Provision PostgreSQL**: Add a PostgreSQL service to your Railway project.
2. **Connect GitHub Repository**: Deploy the repository as a Web service (Railway automatically detects the `Dockerfile`).
3. **Environment Variables**: Configure the following variables in the Railway service settings:
   - `DATABASE_URL`: `${{Postgres.DATABASE_URL}}`
   - `RAILS_MASTER_KEY`: Your `config/master.key` value
   - `GEMINI_API_KEY`: Your Google Gemini API key
   - `RAILS_ENV`: `production`
   - `RAILS_LOG_TO_STDOUT`: `enabled`
4. **Start Command & Networking**:
   - Start Command: `./bin/rails server -b 0.0.0.0 -p 3000` (database migrations run automatically on boot via `bin/docker-entrypoint`).
   - Public Networking Port: `3000`.

---

## 🤝 Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

---

## 📄 License

This project is open source and available under the [MIT License](LICENSE).

## 📧 Contact

**Sara Spadari**
- GitHub: [@sarasp22](https://github.com/sarasp22)
- LinkedIn: [Sara Spadari](https://www.linkedin.com/in/sara-spadari)

---

*Idiomary — Break the ice in every language* 🌍✨
