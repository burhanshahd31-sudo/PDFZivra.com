---
title: PDFMaster
emoji: 📑
colorFrom: blue
colorTo: indigo
sdk: docker
app_port: 7860
pinned: false
---

# PDFMaster — All-in-One SaaS PDF Suite, Forms Center & Subscription Platform

## Netlify static deployment

Netlify publishes the committed `public/` static export. Its HTML pages and referenced
branding, illustrations, CSS, and JavaScript are included, so no Laravel or Vite
build is required. The deploy command checks that `public/index.html` exists.
Composer scripts are disabled on Netlify because this export does not include the
Laravel application bootstrap. Netlify does not execute PHP; Laravel routes, PDF
processing, accounts, and payments require a separate PHP backend and are not
provided by this static deployment. Update the files in `public/` when publishing
a new static export. Do not publish the repository root or entire deployment
archives, which contain server files and private uploads.

<p align="center">
  <img src="https://raw.githubusercontent.com/laravel/art/master/logo-lockup/5%20SVG/2%20CMYK/1%20Full%20Color/laravel-logolockup-cmyk-red.svg" width="300" alt="Laravel Logo">
</p>

PDFMaster is a modern, high-performance SaaS PDF processing platform powered by Laravel 12 and PHP 8.2+. It offers 68+ production-ready PDF manipulation tools, interactive government & tax form generators, electronic signatures, OCR, and AI customer support with tiered subscriptions (Free, Pro, Business) and QR Code / bank transfer payments.

---

## ✨ Features

- **68+ PDF Tools**: Merge, Split, Compress, Rotate, Protect, Unlock, Watermark, Page Numbering, OCR, PDF to Image, Image to PDF, Office Conversions, and more.
- **Official Forms Center**: Ready-to-fill interactive PDF forms for international visas, IRS tax documents, company NDAs, and rental agreements.
- **Subscription & Quota Management**: Free, Pro ($9.99/mo), and Business ($29.99/mo) plans with daily operation quotas and file size limits.
- **Seamless QR Code Payments**: Instant QR Code and bank transfer order verification with admin approval workflow.
- **Privacy & Security**: Automated file purging, encrypted file storage, and instant client-side preview.
- **Interactive AI Chatbot**: Built-in support assistant supporting English, Urdu, and Punjabi.
- **Responsive Modern UI**: SaaS-grade glassmorphism interface built with Bootstrap 5.3 and Bootstrap Icons.

---

## 🚀 Running on Hugging Face Spaces

This Space runs as a self-contained Docker container configured for Hugging Face Spaces:
- **Port**: `7860` (defined in `app_port: 7860`)
- **Runtime**: PHP 8.2 CLI Server with concurrent worker processes (`PHP_CLI_SERVER_WORKERS=4`)
- **Database**: SQLite (pre-configured with all 68 tools, categories, and sample forms)
- **User Compatibility**: Fully compatible with Hugging Face non-root UID `1000`

---

## 🔑 Default Superadmin Access

For administrative access, log in at `/login`:
- **Email**: `admin@pdfmaster.com`
- **Password**: `admin123456`

---

## 🛠 Local Setup

If running locally:
```bash
git clone https://huggingface.co/spaces/Burhan45/PDFMaster
cd PDFMaster
composer install
cp .env.example .env
php artisan key:generate
php artisan migrate --force
php artisan db:seed --force
php artisan serve --port=9000
```
