# Sols RNG Biome Macro

Advanced automation script for the game Sols RNG. It monitors biomes, merchants, and rare events automatically and sends real-time alerts to your Discord.

## ⚡ Features

*   **Smart Hybrid Detection:** The script detects when you are in the normal world or in The Limbo, automatically adjusting the reading method to ensure no rare biome (like Glitched or Cyberspace) goes unnoticed.
*   **In-Game Notifications:** Clean, stacked interface that shows multiple alerts simultaneously without blocking your gameplay.
*   **Discord Alerts:** Receive detailed information, images, and private server links immediately after something important happens.
*   **Built-in Anti-AFK:** Optional feature to prevent you from being kicked from the server for inactivity.
*   **Multi-Webhook Support:** Send alerts to multiple Discord channels at the same time.

---

## 📋 Quick Script Loader

Copy the code below, fill in the fields, and paste it directly into your executor.

```lua
PSLink = "YOUR_FULL_PRIVATE_SERVER_LINK_HERE"
Webhook = "YOUR_DISCORD_WEBHOOK_URL_HERE"
DiscordId = "YOUR_DISCORD_USER_ID_HERE"
AntiAfk = false

loadstring(game:HttpGet("https://raw.githubusercontent.com/gustaslaoq/MobileMacro/refs/heads/main/android.lua", true))()
```

---

## 🚀 How to Use (Detailed Guide)

This script runs on Roblox executors (like Hydrogen, Fluxus, Delta, etc.).

### 1. Setting Up the Variables

Before executing, you need to fill in your information in the loader code.

*   **PSLink:** Must be the **full link** (e.g., `.../SOLS-RNG?privateServerLinkCode=...`). **Do not use Share Links** (`.../share?code=...`), as they expire or are single-use, which will prevent you from joining the server later.
*   **Webhook:** Go to your Discord channel settings > Integrations > Webhooks > Create Webhook and copy the URL. You can use multiple links like `{"link1", "link2"}`.
*   **DiscordId:** (Optional) To find your ID, enable "Developer Mode" in Discord User Settings and right-click your name.
*   **AntiAfk:** Set to `true` to enable or `false` to disable.

### 2. Executing the Script

1.  Open your executor inside Roblox.
2.  Paste the code you edited.
3.  Click on **Execute**.

That's it! You will see a notification saying "Script Started" and receive a log on Discord.

---

## ❓ Frequently Asked Questions (FAQ)

**Does the game need to be in English?**
Yes. To ensure the script correctly reads the names of biomes and merchants, your Roblox game must be set to English.

**Does it detect merchants outside of The Limbo?**
Yes! The script monitors merchants (Mari and Jester) globally, regardless of whether you are in The Limbo or the normal map.

**Can I put more than one Webhook?**
Yes. You can put multiple links separated by commas inside braces, for example:
`Webhook = {"https://discord.com/...", "https://discord.com/..."}`

**How do I stop the script?**
Type `/stop` in the game chat. The script will send a session summary to Discord and re-teleport you.

---

## ⚠️ Disclaimer

This script is provided for educational and personal automation purposes. Use responsibly.

---

**Version:** v2.3 HYBRID EDITION
**Developed by:** gustaslaoq
