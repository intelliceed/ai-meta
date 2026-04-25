# Draw.io MCP Integration

> **Last Updated**: 2026-02-09

MCP server integration for creating and editing draw.io diagrams directly from Claude Code.

## 🎯 What This Provides

Claude Code gains ability to:
- Create diagrams (architecture, ER diagrams, flowcharts)
- Edit existing diagram elements
- Manage layers and styles
- Export results

**Key Feature**: Claude can see diagram structure and modify it through MCP commands.

---

## ⚙️ Installation

### Step 1: Install Browser Extension

> ⚠️ **Important**: Extension works only in **Google Chrome**. Firefox has issues - use Chrome.

#### Download Extension

1. Go to [GitHub Releases](https://github.com/lgazo/drawio-mcp-extension/releases)
2. Download latest release (v1.6.1 or newer)
3. Unzip the downloaded file

#### Install in Chrome

1. Open Chrome and navigate to `chrome://extensions/`
2. Enable **Developer mode** (toggle in top right corner)
3. Click **Load unpacked**
4. Select the unzipped extension folder
5. Extension icon should appear in toolbar

**Verify**: Extension icon appears in browser toolbar.

### Step 2: Configure MCP in Claude Code

Add to `.claude/settings.json`:

```json
{
  "mcpServers": {
    "drawio": {
      "command": "npx",
      "args": ["-y", "drawio-mcp-server"]
    }
  }
}
```

**Alternative** (if using pnpm):
```json
{
  "mcpServers": {
    "drawio": {
      "command": "pnpm",
      "args": ["dlx", "drawio-mcp-server"]
    }
  }
}
```

**Custom Port** (if needed):
```json
{
  "mcpServers": {
    "drawio": {
      "command": "npx",
      "args": ["-y", "drawio-mcp-server", "--extension-port", "8080"]
    }
  }
}
```

### Step 3: Restart Claude Code

```bash
# Exit current session and start fresh
claude
```

---

## 🚀 Quick Start

### 1. Open draw.io

In Chrome navigate to [app.diagrams.net](https://app.diagrams.net) or [draw.io](https://draw.io)

**Create new diagram** (Blank Diagram → Create).

### 2. Verify Connection

Click Draw.io MCP extension icon:
- 🟢 **Green** = Connected (all good!)
- 🟠 **Orange** = Connecting...
- 🔴 **Red** = Disconnected (check if Claude Code is running)

### 3. Request Diagram from Claude

In Claude Code:

```
Create architecture diagram with three services:
- API Gateway
- User Service
- Database

Connect them with arrows labeled "HTTP" and "SQL"
```

Claude Code will:
1. Use MCP tools (add-rectangle, add-edge)
2. Diagram **appears in browser in real-time**
3. You see changes immediately in draw.io

---

## 🛠️ Available Tools

Claude Code gets access to these MCP commands:

### Creating Elements
- `add-rectangle` — rectangles (services, components)
- `add-edge` — arrows and connections between elements
- `add-cell-of-shape` — shapes from library (clouds, databases, actors)

### Editing
- `edit-cell` — change text, size, position
- `edit-edge` — modify arrow labels
- `set-cell-shape` — apply library style
- `delete-cell-by-id` — remove element

### Inspection
- `get-selected-cell` — see what's selected in draw.io
- `list-paged-model` — get all diagram elements
- `get-shape-categories` — list shape categories (AWS, Azure, UML, etc.)
- `get-shapes-in-category` — shapes in category

### Layers
- `list-layers` — all layers
- `create-layer` — new layer
- `set-active-layer` — active layer for new elements
- `move-cell-to-layer` — move element to different layer

---

## 🔧 Troubleshooting

### Extension Not Connecting (🔴 red)

1. **Check if Claude Code is running**
   MCP server starts automatically when Claude Code launches.

2. **Verify port in extension settings**
   - Click extension icon → Settings (⚙️)
   - Default port: **3333**
   - If changed in `.claude/settings.json` — use same port here

3. **Restart everything**
   ```bash
   # 1. Close Claude Code
   # 2. Reload draw.io page in Chrome
   # 3. Start Claude Code again
   claude
   ```

### Diagram Not Updating

- Ensure draw.io is open **in Chrome** (not Firefox!)
- Check that diagram tab is active
- Sometimes page refresh helps (F5)

### Extension Not Loading

If extension shows errors in `chrome://extensions/`:
- Make sure you downloaded the **Chrome** build (not Firefox)
- Try re-downloading from [latest release](https://github.com/lgazo/drawio-mcp-extension/releases)
- Check Chrome version is up to date

---

## 🔗 Links

- [MCP Server (GitHub)](https://github.com/lgazo/drawio-mcp-server)
- [Browser Extension (GitHub)](https://github.com/lgazo/drawio-mcp-extension)
- [Extension Releases](https://github.com/lgazo/drawio-mcp-extension/releases)
- [Draw.io Official](https://app.diagrams.net)

---

## 💡 Best Practices

1. **Open draw.io before asking Claude**
   You'll see results immediately.

2. **Use specific shape names**
   Instead of "make it pretty" → "use AWS style for EC2 and RDS"

3. **Ask Claude to show structure first**
   "First show element list via list-paged-model, then edit"

4. **Save diagrams manually**
   MCP doesn't auto-save files — use File → Save in draw.io.

---

## 🎨 Diagram Style Guidelines

**Always reference rules when creating diagrams:**

```
@mcp/drawio/DIAGRAM_RULES.md - Create AWS architecture:
CloudFront → ALB → ECS → RDS
```

This ensures Claude follows the complete specification: planning phase, grid alignment, spacing rules, no crossings.

See **[DIAGRAM_RULES.md](./DIAGRAM_RULES.md)** for full specification.

---

**Made with ❤️ for Ticketmaster AI Engineering**