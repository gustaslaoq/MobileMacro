***

# Sol's RNG Biome Script

Advanced automation script for the game Sols RNG. It monitors biomes, merchants, rare events, and player auras automatically, sending real-time alerts to your Discord.

## ⚡ Features

*   **Intuitive UI Configuration:** No need to edit code or variables manually. The script now features a full User Interface where you can input your Webhook, Private Server Link, and settings with ease. Settings are saved automatically.
*   **Hybrid Detection:** The script detects when you are in the normal world or in The Limbo, automatically adjusting the reading method to ensure no rare biome (like Glitched or Dreamspace) goes unnoticed.
*   **Aura Detection:** Automatically detects when you roll an aura and sends the details to Discord.
*   **Configurable Ping System:** Set a rarity threshold via the UI to receive Discord mentions only for auras that meet a specific rarity requirement.
*   **In-Game Notifications:** Clean, stacked interface that shows multiple alerts simultaneously without blocking your gameplay.
*   **Discord Alerts:** Receive detailed information, images, and private server links immediately after something important happens.
*   **Built-in Anti-AFK:** Toggle this feature directly from the UI to prevent being kicked from the server for inactivity.
*   **Session Statistics:** Track your progress in real-time with a dedicated "Status" tab showing session duration, biome counts, and merchant encounters.

---

## ⚠️ Important Requirements

Before running the script, ensure your game settings are correct, or the script **will not work**:

1.  **Game Language:** Your Roblox game language must be set to **English**.
2.  **Notification Settings:** Inside the game, open the settings menu, go to the **Notifications** tab, and ensure **"Global Messages Enabled" is DISABLED** so that the script does not send duplicate messages.
3.  **Server Message Ignore Rarity:** The script by default will detect only 100k+ auras, but you can configure that inside the UI settings.

---

## 📋 Script

Copy the loader code below and paste it directly into your executor. **Do not edit the code.** All configuration is done inside the game UI.

```lua
loadstring(game:HttpGet("https://raw.githubusercontent.com/gustaslaoq/MobileMacro/refs/heads/main/android.lua", true))()
```

---

## 🚀 How to Use (Step-by-Step Tutorial)

This script runs on Roblox executors (like Hydrogen, Fluxus, Delta, etc.). Follow the steps below to configure and run it using the new UI:

### 1. Executing the Script

1.  Open your executor inside Roblox.
2.  Copy the loader code provided above.
3.  Paste it into the script area of your executor.
4.  Click on **Execute** (or Play/Inject).

### 2. Configuring via UI

Once executed, a window titled **"Biome Script Config"** will appear on your screen. Here is how to set it up:

#### Tab: Main
*   **Webhook URL:** Paste your Discord Webhook URL in the input box.
*   **Private Server Link:** Paste your full Private Server Link (PSLink) here.
    *   *Tip:* Do not use Share Links (`.../share?code=...`), use the permanent link format (`.../privateServerLinkCode=...`).
*   **Anti-AFK:** Toggle this switch to enable or disable the Anti-AFK feature.
*   **Start Macro:** Click this button to start the automation.

#### Tab: Extra
*   **Discord IDs to Ping:** Enter your Discord User ID (or multiple IDs separated by commas) to be mentioned when rare auras are found.
*   **Ping Threshold:** Set the minimum rarity required to trigger a Discord mention (e.g., set to `999000000` to be pinged for very rare auras).
*   **Stop Macro & Rejoin:** Use this button to safely stop the script and rejoin the server.

#### Tab: Status
*   View real-time statistics including **Status** (Running/Stopped), **Session Time**, **Biome Count**, and **Merchant Count**.

---

## ❓ Frequently Asked Questions (FAQ)

**Does the game need to be in English?**
Yes. To ensure the script correctly reads the names of merchants, biomes, and auras, your Roblox game must be set to English.

**Do I need to edit the script code?**
**No.** The old method of editing variables inside the code is deprecated. All settings (Webhook, PSLink, IDs) should be changed using the in-game UI. Your settings are saved automatically for future uses.

**How does the Aura Ping work?**
Inside the "Extra" tab of the UI, set the "Ping Threshold".
*   *Example:* If you set the threshold to `100000000` (100m), and you roll an aura with a rarity of 1 in 50m, you will **not** be pinged. If you roll an aura of 1 in 100,000,000+, you **will** be pinged.

**Does it detect merchants outside of The Limbo?**
Yes! The script monitors merchants (Mari, Jester, Rin) globally, regardless of whether you are in The Limbo or the normal map.

**How do I stop the script?**
You can type `/stop` in the game chat, or click the "Stop Macro" button inside the UI.

---

## ⚠️ Disclaimer

This script is provided for educational and personal automation purposes. Use responsibly.

---

**Version:** v3.0 JUSTICE edition
**Developed by:** gustaslaoq (on discord)
