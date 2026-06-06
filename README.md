# Sol's RNG Biome Script - Advanced Automation

A configurable automation and notification tool for **Sol's RNG**.  
Track biomes, merchants, Eden, auras, fishing, automation tasks, and Discord alerts through a clean in-game UI.

> **Version:** v3.8  
> **Developed by:** gustaslaoq

---

## Features

- **Persistent Configuration** - Saves your webhooks, private server link, pings, automation rules, UI options, and stats.
- **Discord Webhook Notifications** - Sends clean embeds for biomes, merchants, Eden, auras, Auto Pop, macro start/stop, and webhook tests.
- **Multiple Webhooks** - Add up to 10 saved webhooks, with individual test and delete buttons.
- **Granular Ping System** - Configure global pings, role pings, biome pings, merchant pings, Eden pings, and custom pings per event.
- **Biome Counts** - Tracks lifetime biome counts and last seen times.
- **Aura Detection** - Supports rarity-based aura alerts and several special aura messages.
- **Anti-AFK** - Optional anti-AFK action with configurable interval.
- **Auto Fishing** - Automatically fishes and tracks fish count.
- **Auto Sell** - Sells fish when your configured fish target is reached.
- **Auto SC/BR** - Uses Strange Controller or Biome Randomizer on a timer.
- **Auto Pop** - Uses selected inventory items when selected biomes appear.
- **Auto Merchant** - Buys configured items from Mari, Jester, or Rin.
- **Auto Collect Clover** - Collects clovers when they appear.
- **Auto Obby Luck Boost** - Collects the Obby luck boost on a timer.
- **Auto Contract with Eden** - Experimental Eden contract automation.
- **Privacy Mode** - Hides public account names in webhook embeds where possible.
- **Auto Execute** - Re-executes the script after teleport or rejoin when supported by your executor.
- **Debug Pathfinding** - Optional visual debug mode for automation movement.

> The Easter event has ended, so Egg, Auto Egg, Egg ESP, and related settings were removed.

---

## Important Requirements

Before running the script, make sure:

1. **Game Language** is set to **English**.
2. Your executor supports `readfile`, `writefile`, `isfile`, and `isfolder` for saved configuration.
3. Your executor supports `queue_on_teleport` if you want to use **Auto Execute**.
4. Your private server link is a permanent Roblox server link, not a temporary share-code link.

---

## Script

Copy and execute:

```lua
loadstring(game:HttpGet("https://raw.githubusercontent.com/gustaslaoq/MobileMacro/refs/heads/main/android.lua", true))()
```

Do not edit the loader. Configure everything inside the UI.

---

## How to Use

### 1. Execute the Script

- Open your executor in Sol's RNG.
- Paste the loader above.
- Execute it.
- The **Biome Script** UI will appear.
- Press **K** to show or hide the UI on PC.

### 2. Configure Main Settings

- Add your private server link.
- Add one or more Discord webhooks.
- Use the webhook test button to verify your webhook.
- Press **Start** to begin macro detection.

### 3. Configure Pings

- Add Discord user IDs or role IDs.
- Enable the events you want to ping.
- Add custom IDs for specific events if needed.
- Mute biomes you want to track without sending webhook alerts.

### 4. Enable Automation

- Turn on only the automation systems you want.
- Configure item rules for Auto Pop or Auto Merchant.
- Keep experimental systems, such as Eden contract, enabled only if you want to test them.

---

## UI Tabs

### Main

The main control area.

| Option | Description |
|--------|-------------|
| **Macro State** | Shows if the macro is online or offline. |
| **Private Server Link** | Saves your private server link. |
| **Add Webhook** | Adds a Discord webhook to your saved webhook list. |
| **Saved Webhooks** | Shows saved webhooks with test and delete actions. |
| **Start** | Starts biome detection and notifications. |
| **Stop** | Stops the running macro session. |
| **Stop and Rejoin** | Stops active work and rejoins the current server. |
| **Unload** | Fully unloads the script and removes the UI. |

### Status

Shows live macro information.

| Metric | Description |
|--------|-------------|
| **Macro State** | Current macro state. |
| **Elapsed Time** | Time since the macro was started. |
| **Last Biome** | Last detected biome and when it was seen. |
| **Biomes Detected** | Biomes detected in the current session. |
| **Merchants Found** | Merchants detected in the current session. |
| **Event Log** | Live UI log for script events. |

### Automation

Contains automation tools.

| System | Description |
|--------|-------------|
| **Auto Fishing** | Fishes automatically. |
| **Fish Before Auto Sell** | Fish target before selling. |
| **Auto Sell** | Sells fish after reaching the target. |
| **Enable SC/BR** | Uses Strange Controller or Biome Randomizer on a timer. |
| **Auto Pop** | Uses configured items when selected biomes appear. |
| **Auto Merchant** | Buys selected items from selected merchants. |
| **Auto Collect Clover** | Collects clovers automatically. |
| **Auto Obby Luck Boost** | Collects the Obby luck boost. |
| **Auto Contract with Eden** | Experimental Eden contract automation. |

### Biome Counts

Shows lifetime biome statistics.

| Metric | Description |
|--------|-------------|
| **Total Biomes** | Total biomes detected across saved sessions. |
| **Per Biome Count** | Individual count for each biome. |
| **Last Seen** | When each biome was last detected. |

### Pings

Controls Discord mentions and filters.

| Option | Description |
|--------|-------------|
| **Discord IDs** | User IDs to mention. |
| **Role IDs** | Role IDs to mention. |
| **Aura Rarity Threshold** | Minimum aura rarity required to ping. |
| **Biome Pings** | Toggle pings for supported biomes. |
| **Merchant Pings** | Toggle pings for Mari, Jester, and Rin. |
| **Eden Ping** | Toggle Eden spawn pings. |
| **Custom Ping IDs** | Event-specific ping IDs. |
| **Muted Biomes** | Track selected biomes without webhook notifications. |

### Settings

Advanced options.

| Option | Description |
|--------|-------------|
| **Biome Scan Interval** | How often the script scans for biome changes. |
| **Anti-AFK Interval** | How often Anti-AFK runs. |
| **Privacy Mode** | Hides public account names in webhook embeds. |
| **Auto Execute** | Queues the script to run after teleport or rejoin. |
| **Auto Reset on Rare Biome** | Optional reset behavior for rare biomes. |
| **Debug Pathfinding** | Shows movement debug visuals. |

---

## Automation Notes

- **Auto Pop** supports multiple biome rules and multiple items per biome.
- **Auto Merchant** supports Mari, Jester, and Rin item lists.
- **Set to Max** can be used for merchant purchases.
- **Auto Contract with Eden** is experimental and may fail depending on the server, UI state, or map state.
- Path-based systems can be interrupted by disabling their toggle.

---

## Frequently Asked Questions

**Q: Do I need to configure the script every time?**  
**A:** No. Your configuration is saved and loaded automatically.

**Q: Can I use more than one webhook?**  
**A:** Yes. You can save up to 10 webhooks.

**Q: Can Auto Fishing and SC/BR run together?**  
**A:** Yes. They are designed to work together.

**Q: Why are some names hidden in embeds?**  
**A:** Privacy Mode is enabled by default.

**Q: Is Auto Contract with Eden stable?**  
**A:** Not fully. It is experimental.

**Q: Where did Egg features go?**  
**A:** The Easter event ended, so Egg-related systems were removed.

---

## Warning

This script is provided for educational and personal automation purposes only. Use it at your own risk. The developer is not responsible for any consequences arising from its use.

---

Found a bug or have a suggestion? Leave a comment or contact **gustaslaoq**.
