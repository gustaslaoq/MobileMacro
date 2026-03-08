# Sol's RNG Biome Script – Advanced Automation

A powerful, configurable automation tool for **Sol's RNG**.  
Monitors biomes, merchants, rare events, and auras, and sends real‑time alerts to your Discord with rich embed notifications.

> **Version:** v3.3.2  
> **Developed by:** gustaslaoq (Discord)

---

## ✨ Features

- **Persistent Configuration** – All your settings (webhook, private server link, Discord IDs, ping toggles) are automatically saved to a file. Set it up **once** and forget it.
- **Granular Ping System** – A dedicated **Pings** tab lets you individually enable/disable pings for:
  - Common biomes (Rainy, Snowy, Sand Storm, Windy, Starfall, Hell, Heaven, Null, Aurora, Corruption)
  - Merchants (Mari, Jester, Rin)
  - Eden (appears in The Limbo)
  
  Rare biomes (Glitched, Dreamspace, Cyberspace) always use `@everyone` by default – no extra config needed.
- **Global Statistics** – Tracks total biomes found across all sessions and displays them in the **Status** tab, so you can see your lifetime progress.
- **Anti‑AFK** – Optional smart movement simulation to prevent being kicked for inactivity (may not work on all devices).
- **Aura Detection** – Recognises rare auras including **Monarch, Pixelation, Luminosity, Nyctophobia, Equinox, BREAKTHROUGH** and more, with custom Discord embeds.

---

## 📋 Important Requirements

Before running the script, ensure your game settings are correct **Or some features may not work**:

1. **Game Language** – Must be set to **English** inside Roblox.
2. **Notification Settings** – In the game’s settings, **disable** “Global Messages Enabled” to avoid duplicate logs.
3. **Executor Compatibility** – Your executor must support `readfile`, `writefile`, and `isfile` (most modern executors do). This is required for configuration saving.

---

## 🚀 Script

Copy the loader code below and paste it directly into your executor. **Do not edit this code** – all configuration is done inside the game UI after execution.

```lua
loadstring(game:HttpGet("https://raw.githubusercontent.com/gustaslaoq/MobileMacro/refs/heads/main/android.lua", true))()
```

---

## 📖 How to Use (Step‑by‑Step Tutorial)

### 1. Execute the Script
- Open your executor inside Roblox.
- Copy the loader code above and paste it into the executor.
- Click **Execute**. A UI window titled **“Slaoq's Biome script – v3.3.2”** will appear.

### 2. Configure the UI

The UI is divided into four tabs. Configure each according to your preferences.

#### 🔹 **Main Tab**
| Field / Button | Description |
|----------------|-------------|
| **Webhook URL** | Paste your Discord webhook URL. After saving, it will be visually shortened for privacy. |
| **Private Server Link** | Paste your permanent private server link (the one containing `.../privateServerLinkCode=...`). |
| **Anti‑AFK** | Toggle to enable/disable the anti‑AFK feature. |
| **Start Macro** | Click to begin biome detection. The button changes to **Stop Macro** while running. |

#### 🔹 **Pings Tab**
- **Discord IDs to Ping** – Enter one or more Discord user IDs (numbers only, comma‑separated). These will be pinged for the events you toggle below.
- **Biomes** – Enable or disable pings for each common biome individually.
- **Merchants** – Toggle pings for Mari, Jester, and Rin.
- **Extra** – Toggle “Ping on Eden” to receive alerts when Eden appears in The Limbo.

> **Note:** Rare biomes (Glitched, Dreamspace, Cyberspace) always ping `@everyone` regardless of these settings.

#### 🔹 **Extra Tab**
- **Ping Threshold (Aura Rarity)** – Set a minimum rarity number (e.g., `100000000` for 100M+) to trigger a Discord mention when a rare aura is rolled.
- **Stop Macro & Rejoin** – Safely stops the macro and rejoins the current server. Useful for testing or resetting.

#### 🔹 **Status Tab**
- Displays real‑time information about the current session:
  - Session time
  - Current status (Running / Stopped)
  - Session biome count and merchant count
  - Last detected biome and time ago
- Also shows **global statistics** (total biomes found since you started using the script), broken down by biome type with last seen timestamps.

---

## ❓ Frequently Asked Questions

**Q: Do I need to configure the script every time I run it?**  
**A:** No. Your configuration is automatically saved to a file. Next time you execute the script, all your settings (webhook, PS link, ping preferences, etc.) will be loaded instantly.

**Q: How does the ping system work?**  
**A:** In the **Pings** tab you have full control. If you only care about “Heaven” and “Jester”, simply enable those toggles and disable the rest. Rare biomes (Glitched, Dreamspace, Cyberspace) override the toggles and always ping `@everyone`.

**Q: What auras does the script detect?**  
**A:** It detects standard auras based on rarity, plus custom detections for: **Monarch, Pixelation, Luminosity, Nyctophobia, Equinox, BREAKTHROUGH** (the new 1B+ detection may require fine‑tuning).

**Q: Is the script open source?**  
**A:** The core logic is closed source to protect integrity, but the loader is provided above for easy use.

---

## 🔧 Alternative: Headless Version (No UI)

If the main script conflicts with other UI‑based scripts (e.g., auto‑fishing scripts) or you prefer a minimal background operation, use this headless version.

### Features
- **High Compatibility** – No UI elements, so it won’t interfere with other custom interfaces.
- **Direct Configuration** – Settings are defined directly in the loader code.

### Script (No UI)

Copy the code below into your executor. **You must edit the variables at the top before executing.**

```lua
PSLink = "";       -- Paste your Private Server Link here
Webhook = "";      -- Paste your Discord Webhook URL here (supports multiple URLs separated by commas or spaces)
DiscordId = "ID1, ID2, ID3";    -- Paste your Discord User IDs here (for Eden, Jester, and Rin pings)
Antiafk = false     -- Set to true to enable Anti-AFK, false to disable (may not work on some devices)

loadstring(game:HttpGet("https://raw.githubusercontent.com/gustaslaoq/MobileMacro/refs/heads/main/androidnoui.lua", true))()
```

### Configuration Guide
1. **PSLink** – Insert your Roblox private server link between the quotes.
2. **Webhook** – Insert your Discord webhook URL. The script automatically detects multiple webhooks if you paste more than one.
3. **DiscordId** – Enter your Discord user ID(s) if you want to be pinged for specific events (Eden, Jester, Rin).
4. **Antiafk** – Keep as `true` to enable the anti‑AFK feature.

---

## ⚠️ Warning

This script is provided for **educational and personal automation purposes only**. Use it at your own risk. The developer is not responsible for any consequences arising from its use.

---


*For bug reports or suggestions, message **gustaslaoq** on Discord.*
