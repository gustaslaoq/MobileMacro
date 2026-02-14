Aqui está o README atualizado com as novas funcionalidades de detecção de aura, requisitos de configuração do jogo e a variável de ping.

# Sol's RNG Biome Script

Advanced automation script for the game Sols RNG. It monitors biomes, merchants, rare events, and player auras automatically, sending real-time alerts to your Discord.

## ⚡ Features

*   **Hybrid Detection:** The script detects when you are in the normal world or in The Limbo, automatically adjusting the reading method to ensure no rare biome (like Glitched or Dreamspace) goes unnoticed.
*   **Aura Detection:** Automatically detects when you roll an aura and sends the details to Discord.
*   **Configurable Ping System:** Set a rarity threshold (`PingThreshold`) to receive Discord mentions only for auras that meet a specific rarity requirement.
*   **In-Game Notifications:** Clean, stacked interface that shows multiple alerts simultaneously without blocking your gameplay.
*   **Discord Alerts:** Receive detailed information, images, and private server links immediately after something important happens.
*   **Built-in Anti-AFK:** Optional feature to prevent you from being kicked from the server for inactivity (in mobile you may still need an autoclicker).
*   **Multi-Webhook Support:** Send embeds to multiple Discord channels at the same time.

---

## ⚠️ Important Requirements

Before running the script, ensure your game settings are correct, or the script **will not work**:

1.  **Game Language:** Your Roblox game language must be set to **English**.
2.  **Notification Settings:** Inside the game, open the settings menu, go to the **Notifications** tab, and ensure **"Global Messages Enabled" is DISABLED**. so that the script does not send duplicate messages
3.  **Server message ignore rarity** The script by default will detect only 100k+ auras, but you can configure that by changing the Server Message Ignore rarity in settings.

---

## 📋 Script

Copy the code below, fill in the fields, and paste it directly into your executor.

```lua
PSLink = "YOUR_FULL_PRIVATE_SERVER_LINK_HERE"
Webhook = "YOUR_DISCORD_WEBHOOK_URL_HERE"
DiscordId = "YOUR_DISCORD_USER_ID_HERE"
AntiAfk = false
PingThreshold = 999000000

loadstring(game:HttpGet("https://raw.githubusercontent.com/gustaslaoq/MobileMacro/refs/heads/main/android.lua", true))()
```

---

## 🚀 How to Use (Step-by-Step Tutorial)

This script runs on Roblox executors (like Hydrogen, Fluxus, Delta, etc.). Follow the steps below to configure and run it:

### 1. Setting Up the Variables

Before executing, you need to fill in your information in the loader code. Copy the block below and edit **only what is inside the quotes** (or the numbers for thresholds).

```lua
-- 1. Paste your Private Server Link (PSLink) here
PSLink = "https://www.roblox.com/games/15532962292/SOLS-RNG?privateServerLinkCode=XXXXX"

-- 2. Paste your Discord Webhook URL here.
-- TIP: If you want to use more than one, use braces: {"link1", "link2"}
Webhook = "https://discord.com/api/webhooks/YOUR_WEBHOOK_HERE"

-- 3. (Optional) Paste your Discord User ID here to be mentioned.
-- TIP: To mention multiple people, use braces: {"id1", "id2"}
DiscordId = ""

-- 4. Change to 'true' if you want to enable Anti-AFK, or 'false' to disable it.
AntiAfk = false

-- 5. (Optional) Aura Ping Threshold.
-- You will be mentioned in Discord if you roll an aura with rarity >= this number.
-- Example: Set to 99999999 to be pinged for auras 99m+.
-- Set to a very high number (like 99999999) to only get pinged when you get a global.
PingThreshold = 999000000

-- 6. Script Loader (DO NOT EDIT THIS)
loadstring(game:HttpGet("https://raw.githubusercontent.com/gustaslaoq/MobileMacro/refs/heads/main/android.lua", true))()
```

#### Configuration Tips:
*   **PSLink:** Must be the **full link** (e.g., `.../SOLS-RNG?privateServerLinkCode=...`). **Do not use Share Links** (`.../share?code=...`), as they expire or are single-use.
*   **Webhook:** Go to your Discord channel settings > Integrations > Webhooks > Create Webhook and copy the URL.
*   **DiscordId:** To find your ID, enable "Developer Mode" in your Discord User Settings and right-click your name.
*   **PingThreshold:** This defines how rare an aura needs to be to trigger a Discord mention (ping). If you only want to be pinged for extremely rare auras, set this number high (e.g., 1,000,000).

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
Yes. To ensure the script correctly reads the names of merchants, biomes, and auras, your Roblox game must be set to English.

**Do I need to change my game settings?**
Yes. Go to the game settings, navigate to the **Notifications** tab, and turn **OFF** "Global Messages". If this is left on, the script may fail to detect events properly due to chat clutter.

**How does the Aura Ping work?**
By setting the `PingThreshold` variable, you define the minimum rarity required to ping you on Discord.
*   *Example:* If you set `PingThreshold = 100000000` (100m), and you roll an aura with a rarity of 1 in 50m, you will **not** be pinged. If you roll an aura of 1 in 100,000,000+, you **will** be pinged.

**Does it detect merchants outside of The Limbo?**
Yes! The script monitors merchants (Mari, Jester, Rin) globally, regardless of whether you are in The Limbo or the normal map.

**Can I put more than one Webhook?**
Yes. You can put multiple links separated by commas inside braces, for example:
`Webhook = {"https://discord.com/...", "https://discord.com/..."}`

**How do I stop the script?**
Type `/stop` in the game chat. The script will send a session summary to Discord and you will rejoin, or just leave the game.

---

## ⚠️ Disclaimer

This script is provided for educational and personal automation purposes. Use responsibly.

---

**Version:** v2.5 JUSTICE edition
**Developed by:** gustaslaoq and dox.__ (on discord)
