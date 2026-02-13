# Sol's RNG Biome Script

Advanced automation script for the game Sols RNG. It monitors biomes, merchants, and rare events automatically and sends real-time alerts to your Discord.

## ⚡ Features

*   **Hybrid Detection:** The script detects when you are in the normal world or in The Limbo, automatically adjusting the reading method to ensure no rare biome (like Glitched or Dreamspace) goes unnoticed.
*   **In-Game Notifications:** Clean, stacked interface that shows multiple alerts simultaneously without blocking your gameplay.
*   **Discord Alerts:** Receive detailed information, images, and private server links immediately after something important happens.
*   **Built-in Anti-AFK:** Optional feature to prevent you from being kicked from the server for inactivity (in mobile you may still need an autoclicker).
*   **Multi-Webhook Support:** Send embeds to multiple Discord channels at the same time.

---

## 📋 Script

Copy the code below, fill in the fields, and paste it directly into your executor.

```lua
PSLink = "YOUR_FULL_PRIVATE_SERVER_LINK_HERE"
Webhook = "YOUR_DISCORD_WEBHOOK_URL_HERE"
DiscordId = "YOUR_DISCORD_USER_ID_HERE"
AntiAfk = false

loadstring(game:HttpGet("https://raw.githubusercontent.com/gustaslaoq/MobileMacro/refs/heads/main/android.lua", true))()
```

---

## 🚀 How to Use (Step-by-Step Tutorial)

This script runs on Roblox executors (like Hydrogen, Fluxus, Delta, etc.). Follow the steps below to configure and run it:

### 1. Setting Up the Variables

Before executing, you need to fill in your information in the loader code. Copy the block below and edit **only what is inside the quotes**.

```lua
-- 1. Paste your Private Server Link (PSLink) here
PSLink = "https://www.roblox.com/games/15532962292/SOLS-RNG?privateServerLinkCode=XXXXX"

-- 2. Paste your Discord Webhook URL here.
-- TIP: If you want to use more than one, use braces: {"link1", "link2"}
Webhook = "https://discord.com/api/webhooks/YOUR_WEBHOOK_HERE"

-- 3. (Optional) Paste your Discord User ID here to be mentioned for jester, eden and others.
-- TIP: To mention multiple people, use braces: {"id1", "id2"}
DiscordId = ""

-- 4. Change to 'true' if you want to enable Anti-AFK, or 'false' to disable it.
AntiAfk = false

-- 5. Script Loader (DO NOT EDIT THIS)
loadstring(game:HttpGet("https://raw.githubusercontent.com/gustaslaoq/MobileMacro/refs/heads/main/android.lua", true))()
```

#### Configuration Tips:
*   **PSLink:** Must be the **full link** (e.g., `.../SOLS-RNG?privateServerLinkCode=...`). **Do not use Share Links** (`.../share?code=...`), as they expire or are single-use, which will prevent you from joining the server later.
*   **Webhook:** Go to your Discord channel settings > Integrations > Webhooks > Create Webhook and copy the URL.
*   **DiscordId:** To find your ID, enable "Developer Mode" in your Discord User Settings and right-click your name.
*   **Quotes:** It is very important to keep the quotes `""` around the links and IDs. If you delete them, the script will error.

---

### 2. Executing the Script

1.  Open your executor inside Roblox.
2.  Copy the code you edited in the previous step.
3.  Paste it into the script area of your executor.
4.  Click on **Execute** (or Play/Inject).

That's it! The script will start, you will see a notification at the top of the screen saying "Script Started", and you will receive a log in your Discord confirming the macro is active.

---

## ❓ Frequently Asked Questions (FAQ)

**Does the game need to be in English?**
Yes. To ensure the script correctly reads the names of merchants, and biomes while in limbo, your Roblox game must be set to English.

**Does it detect merchants outside of The Limbo?**
Yes! The script monitors merchants (Mari and Jester) globally, regardless of whether you are in The Limbo or the normal map.

**Can I put more than one Webhook?**
Yes. You can put multiple links separated by commas inside braces, for example:
`Webhook = {"https://discord.com/...", "https://discord.com/..."}`

**I have a Share Link (`.../share?code=...`), how do I get the Private Server Link?**
Share links often expire or are for single use. To get the permanent Private Server Link:
1.  Open the Share Link in your web browser (Chrome, Edge, etc.).
2.  Wait for the page to load and redirect to the Roblox game page.
3.  Copy the full URL from your browser's address bar.
4.  Use this new link in the `PSLink` variable.

**How do I stop the script?**
Type `/stop` in the game chat. The script will send a session summary to Discord and you will rejoin, or just leave the game.

---

## ⚠️ Disclaimer

This script is provided for educational and personal automation purposes. Use responsibly.

---

**Version:** v2.3.2 HYBRID EDITION
**Developed by:** gustaslaoq and dox.__ (on discord)
