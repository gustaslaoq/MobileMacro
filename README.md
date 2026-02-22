***

# Sol's RNG Biome Script

Advanced automation script for **Sol's RNG**. It monitors biomes, merchants, rare events, and auras automatically, sending alerts to your Discord with detailed embeds.

## Features

*   **Persistent Configuration:** Your settings (Webhook, PSLink, Discord IDs, Toggle states) are automatically saved to a file. You only need to configure it once!
*   **Granular Ping System:** New dedicated **"Pings"** tab. Instead of always pinging for jester and eden, you can now individually toggle pings for specific biomes (Rainy, Snowy, etc.) and merchants (Mari, Jester, Rin). Rare biomes (Glitched, Dreamspace, Cyberspace) still use `@everyone` by default.
*   **Input Privacy:** The UI automatically shortens your Webhook and Private Server links visually, preventing screen sharing leaks, but keeps the full link saved internally.
*   **Global Statistics:** Tracks your total biomes found across all sessions and displays them in the "Status" tab.

---

## Important Requirements

Before running the script, ensure your game settings are correct, or the script **will not work**:

1.  **Game Language:** Your Roblox game language must be set to **English**.
2.  **Notification Settings:** Inside the game settings, ensure **"Global Messages Enabled" is DISABLED** to prevent duplicate logs.
3.  **Executor Support:** Your executor must support `readfile`, `writefile`, and `isfile` functions to save settings (most modern executors do).

---

## Script

Copy the loader code below and paste it directly into your executor. **Do not edit the code.** All configuration is done inside the game UI.

```lua
loadstring(game:HttpGet("https://raw.githubusercontent.com/gustaslaoq/MobileMacro/refs/heads/main/android.lua", true))()
```

---

## How to Use (Step-by-Step Tutorial)

### 1. Executing the Script
1.  Open your executor inside Roblox.
2.  Copy the loader code provided above.
3.  Paste and click **Execute**.

### 2. Configuring via UI (New Rayfield Interface)

Once executed, a window titled **"Slaoq's Biome script - v3.3.0"** will appear.

#### Tab: Main
*   **Webhook URL:** Paste your Discord Webhook. The UI will shorten it visually for privacy after saving.
*   **Private Server Link:** Paste your PSLink (`.../privateServerLinkCode=...`).
*   **Anti-AFK:** Toggle to enable the smart walking anti-AFK.
*   **Start Macro:** Click to begin automation.

#### Tab: Pings
*   **Discord IDs to Ping:** Enter your User ID (or multiple separated by commas).
*   **Biomes:** Toggle specifically which common biomes should ping you (e.g., check "Ping on Rainy" if you want alerts for that).
*   **Merchants:** Toggle specific alerts for Mari, Jester, or Rin.
*   **Extra:** Toggle "Ping on Eden" if you want alerts when Eden appears in the Limbo.
*   *Note:* Rare biomes (Glitched, Dreamspace, Cyberspace) automatically ping `@everyone` regardless of settings.

#### Tab: Extra
*   **Ping Threshold:** Set the minimum rarity number to trigger a Discord mention for auras (e.g., `100000000` for 100m+).
*   **Stop Macro & Rejoin:** Safely stops the script and rejoins the server.

#### Tab: Status
*   View **Session Time**, **Current Status**, **Session Counts**, and **Total Biomes** found since you started using the script.

---

## Frequently Asked Questions (FAQ)

**Do I need to configure the script every time?**
**No.** The script now saves your configuration automatically to a file. Next time you execute it, it will load your Webhook, PSLink, and Ping settings instantly.

**How does the new Ping system work?**
In the **"Pings"** tab, you have full control. If you only care about "Starfall" and "Mari", simply enable the toggles for those and disable the rest. Rare biomes override this and always alert `@everyone`.

**What auras does it detect?**
It detects standard auras based on rarity, plus specific custom detections for: **Monarch, Pixelation, Luminosity, Nyctophobia, Equinox, BREAKTHROUGH, and Matrix : Steampunk**.

**Is the code open source?**
The script logic is closed source to protect integrity, but the loader is provided above for easy use.

---

## Alternative: Headless Version (No UI)

If the main script is not working correctly or conflicts with other scripts (e.g., beeconhub (autofishing script), use this headless version. It has no interface and runs entirely in the background.

### Features
*   **High Compatibility:** No UI elements, ensuring no conflicts with other custom interfaces.
*   **Direct Configuration:** Settings are defined directly in the loader code.

### Script (No UI)

Copy the code below into your executor. **You must edit the variables at the top before executing.**

```lua
PSLink = "";       -- Paste your Private Server Link here
Webhook = "";      -- Paste your Discord Webhook URL here (supports multiple webhooks separated by commas or spaces)
DiscordId = "ID1, ID2, ID3";    -- Paste your Discord User ID here (for eden, jester and rin)
Antiafk = false     -- Set to true to enable Anti-AFK, false to disable (may not work on some devices)

loadstring(game:HttpGet("https://raw.githubusercontent.com/gustaslaoq/MobileMacro/refs/heads/main/androidnoui.lua", true))()
```

### Configuration Guide
1.  **PSLink:** Paste your Roblox Private Server link between the quotes.
2.  **Webhook:** Paste your Discord Webhook URL. The script automatically detects multiple webhooks if you paste more than one.
3.  **DiscordId:** Enter your Discord User ID if you want to be pinged for specific events.
4.  **Antiafk:** Keep as `true` to prevent being kicked for inactivity.

---

## Warning

This script is provided for educational and personal automation purposes. Use at your own risk.

---

**Version:** v3.3.1
**Developed by:** gustaslaoq (on discord)
