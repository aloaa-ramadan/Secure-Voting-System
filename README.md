# 🗳️ Secure Voting System – EMU8086 Assembly Project

A secure voting system developed using **8086 Assembly Language** in **EMU8086**.  
The system allows users to cast votes, prevents duplicate voting, and enables an administrator to view results after password authentication.

---

## 📌 Project Overview

This project simulates a simple electronic voting machine with the following features:

- 🗳️ Voting for one of two candidates:
  - Alaa
  - Sarah
- 🔒 Prevents duplicate voting using voter IDs
- 🔑 Admin login with password protection
- 📊 Displays voting results
- 🏆 Announces the winner or declares a draw
- 🚪 Exit option

---

## ⚙️ Features

### 👤 User Module
- Enter a voter ID.
- Checks if the ID has already voted.
- Select a candidate.
- Vote is recorded successfully.
  
## 🔐 Password Encryption

To improve security, the admin password is stored in encrypted form using the XOR instruction.

- **Encryption Key:** `55h`
- **Original Password:** `1234`
- **Encrypted Password:** `64h, 67h, 66h, 61h`

### 🔐 Admin Module
- Requires a 4-digit password (`1234`).
- Allows 3 attempts.
- Displays:
  - Number of votes for each candidate.
  - Winner announcement.

### 🛡️ Duplicate Vote Protection
- Stores voter IDs in memory.
- Prevents any ID from voting more than once.

---

## 🧠 Technologies Used

- Assembly Language (8086)
- EMU8086
- DOS Interrupts (INT 21h)

---

## 📂 Project Structure

- SecureVotingSystem.asm

- README.md

---

## 🎥 Demo Video

Watch the full project explanation here:

[Project Demo Video](https://drive.google.com/file/d/1wJddJQ7Cs4O9DC3WvWZxUXeXm0aybdXf/view?usp=drive_link)

---

## 🔗 LinkedIn Profile

[My LinkedIn Profile](https://www.linkedin.com/in/alaa-ramadan-/)

---

## 👩‍💻 Author

**Alaa Ayman Ramadan**

---

## 📄 License

This project was developed for educational purposes as part of learning 8086 Assembly Language and EMU8086.
