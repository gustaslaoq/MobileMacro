# Sol's RNG Biome Script – Advanced Automation

A powerful, configurable automation tool for **Sol's RNG**.  
Monitors biomes, merchants, eggs, rare events and auras, and sends real‑time alerts to your Discord with rich embed notifications.

> **Version:** v3.7  
> **Developed by:** gustaslaoq (Discord)

---

## ✨ Features

- **Persistent Configuration** – All your settings (webhook, private server link, Discord IDs, ping toggles) are automatically saved to a file. Set it up **once** and forget it.
- **Granular Ping System** – A dedicated **Pings** tab lets you individually enable/disable pings for:
  - Common biomes (Rainy, Snowy, Sand Storm, Windy, Starfall, Hell, Heaven, Null and more)
  - Merchants (Mari, Jester, Rin)
  - Eden (appears in The Limbo)
  - Eggs (Hatch, Royal, Andromeda, Angelic, Blooming, Forest, The Egg of the Sky, Egg V2, Dreamer)
  
  Rare biomes (Glitched, Dreamspace, Cyberspace) always use `@everyone` by default – no extra config needed.
- **Custom Ping IDs per Event** – Each biome, merchant or egg ping can have its own set of Discord user/role IDs, separate from the global IDs.
- **Global Statistics** – Tracks total biomes found across all sessions and displays them in the **Biome Counts** tab.
- **Anti‑AFK** – Optional smart movement simulation to prevent being kicked for inactivity.
- **Aura Detection** – Recognises rare auras including **Monarch, Pixelation, Luminosity, Nyctophobia, Equinox, BREAKTHROUGH, Matrix: Steampunk** and more, with custom Discord embeds.
- **Egg Hunt ESP** – Displays a live ESP overlay on all eggs in the map, showing the egg name and distance in studs.
- **Auto Egg Farm** – Pathfinds automatically to nearby eggs using Roblox's pathfinding service. Configurable max distance, max height difference, priority mode (proximity or smart/rarity-based) and stuck behaviour.
- **Auto Fishing** – Automatically casts, runs the fishing minigame and tracks your fish count.
- **Auto Sell** – Walks to the NPC and sells all fish once a configurable target count is reached.
- **SC/BR Biome Randomizer** – Automatically uses Strange Controller or Biome Randomizer from your inventory on a configurable timer. Runs in parallel with Auto Fishing.
- **Multiple Webhook Support** – Paste multiple Discord webhook URLs; the script sends to all of them with automatic retry and rate‑limit handling.

---

## 📋 Important Requirements

Before running the script, ensure your game settings are correct **or some features may not work**:

1. **Game Language** – Must be set to **English** inside Roblox.
2. **Notification Settings** – In the game's settings, **disable** "Global Messages Enabled" to avoid duplicate logs.
3. **Executor Compatibility** – Your executor must support `readfile`, `writefile`, `isfile` and `isfolder` (most modern executors do). Required for configuration saving.

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
- Click **Execute**. A UI window titled **"Biome Script"** will appear. Press **K** to show/hide it at any time.

### 2. Configure the UI

The UI is divided into six tabs. Configure each according to your preferences.

#### 🔹 Main Tab
| Field / Button | Description |
|----------------|-------------|
| **Macro State** | Status badge showing whether the macro is currently running or stopped. |
| **Start** | Click to begin biome detection. Requires a valid webhook URL. |
| **Stop** | Click to stop the macro. |
| **Discord Webhook URL** | Paste your Discord webhook URL here. Supports multiple webhook URLs separated by commas or spaces. After saving, it will be visually shortened for privacy. |
| **Test Webhook** | Sends a test message to each configured webhook and notifies you on-screen whether each one is working. Has a 10-second cooldown. |
| **Private Server Link** | Paste your permanent private server link (must be a permanent link, not a share link). After saving, it will be visually shortened. |
| **Anti‑AFK** | Toggle to enable/disable the anti‑AFK feature. |
| **Stop and Rejoin** | Safely stops the macro and rejoins the current server. |
| **Egg ESP** | Toggle to show a live ESP overlay on all eggs in the map with name and distance. |
| **Auto Egg Farm** | Toggle to enable automatic pathfinding to nearby eggs. |

#### 🔹 Status Tab
Displays real‑time information about the current macro session:

| Metric | Description |
|--------|-------------|
| **Macro State** | Live badge showing Running or Stopped. |
| **Elapsed Time** | How long the current session has been running (hh:mm:ss). |
| **Last Biome** | The last biome detected and how long ago it was seen. |
| **Biomes Detected** | Total biomes found during this session. |
| **Merchants Found** | Total merchants found during this session. |
| **Event Log** | A live scrollable console logging all macro events with timestamps. |

#### 🔹 Automation Tab
| Field / Toggle | Description |
|----------------|-------------|
| **Enable SC/BR (Biome Randomizer)** | Automatically uses Strange Controller or Biome Randomizer on a timer. |
| **Use Interval (Minutes)** | How often (in minutes) to use the SC/BR item. Range: 1–120. |
| **Auto Fishing** | Automatically casts and runs the fishing minigame. |
| **Fish Before Auto Sell** | Number of fish to catch before triggering Auto Sell. Range: 1–999. |
| **Auto Sell** | Automatically walks to the NPC and sells fish when the target is reached. |
| **Live Status** | Real-time metrics: fish count, SC/BR timer, and active system state. |

#### 🔹 Biome Counts Tab
Shows your **lifetime statistics** across all sessions:

| Metric | Description |
|--------|-------------|
| **Total Biomes** | Overall biome count across every session. |
| **Per Biome** | Individual count and last seen time for each biome type. |

#### 🔹 Pings Tab
| Field / Toggle | Description |
|----------------|-------------|
| **Discord IDs to Ping** | Enter one or more Discord user IDs (numbers only, comma‑separated). |
| **Role IDs to Ping** | Enter one or more Discord role IDs to mention on events. |
| **Aura Rarity Ping Threshold** | Minimum rarity number (e.g. `100000000`) to trigger a ping on aura rolls. |
| **Biome Pings** | Individual toggles for each common biome. Each toggle can have its own custom user/role IDs. |
| **Merchant Pings** | Individual toggles for Mari, Jester, and Rin. Each can have custom IDs. |
| **Ping on Eden spawn** | Toggle to receive alerts when Eden appears in The Limbo. |
| **Egg Pings** | Individual toggles for each egg type. Each can have custom IDs. |

> **Note:** Rare biomes (Glitched, Dreamspace, Cyberspace) always ping `@everyone` and are not listed in the toggles.

#### 🔹 Settings Tab
| Field | Description |
|-------|-------------|
| **Biome Scan Interval** | How often (in seconds) the script scans for the current biome. Default: 0.5s. |
| **Anti‑AFK Interval** | How often (in seconds) the anti-AFK action fires. Default: 300s. |
| **Egg Max Distance** | Maximum stud distance to consider an egg as a target. Default: 1500. |
| **Egg Max Height Difference** | Maximum vertical stud difference to consider an egg reachable. Default: 40. |
| **Egg Priority** | `Proximity` (closest first) or `Smart` (prioritise rarer eggs). |
| **Egg On Stuck** | What to do when pathfinding gets stuck: `Blacklist Egg`, `Send to Back of Queue`, or `Reset to Spawn`. |
| **Muted Biomes** | Select biomes to silence — they will still be tracked in stats but won't trigger notifications or webhooks. |

---

## ❓ Frequently Asked Questions

**Q: Do I need to configure the script every time I run it?**  
**A:** No. Your configuration is automatically saved. Next time you execute the script, all settings will be loaded instantly.

**Q: How does the custom ping system work?**  
**A:** Each event (biome, merchant, egg) can use the global Discord IDs, or you can enable the event's toggle and fill in a custom IDs field that appears below it to ping only specific people for that one event.

**Q: Can Auto Fishing and SC/BR run at the same time?**  
**A:** Yes. All three systems (Auto Fishing, Auto Sell and SC/BR) run in parallel without interfering with each other.

**Q: What auras does the script detect?**  
**A:** Standard auras by rarity, plus custom detections for: **Monarch, Pixelation, Luminosity, Nyctophobia, Equinox, BREAKTHROUGH, Matrix: Steampunk**.

**Q: Is the script open source?**  
**A:** The core logic is closed source to protect integrity, but the loader is provided above for easy use.

---

## ⚠️ Warning

This script is provided for **educational and personal automation purposes only**. Use it at your own risk. The developer is not responsible for any consequences arising from its use.

---

*For bug reports or suggestions, message **gustaslaoq** on Discord.*
