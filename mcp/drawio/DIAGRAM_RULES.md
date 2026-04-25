# Diagram Layout Specification (draw.io / MCP)

You must strictly follow this specification when generating diagrams.
If any rule is violated, the layout must be regenerated.

---

## 0. MANDATORY PLANNING PHASE (Must Complete Before Execution)

**CRITICAL**: You must **never** start creating diagram elements without completing the full planning phase first.

### 0.1 Planning Steps (Sequential)

#### Step 1: Analyze Requirements
* Understand what needs to be visualized
* Identify all components and their relationships
* Determine the primary flow direction (Top→Bottom or Left→Right)

#### Step 2: Plan All Elements
* List every element that will appear in the diagram
* Assign each element to a logical level (row/column)
* Determine element types and base sizes:
  * Process: 160×80
  * Decision: 160×100
  * Data/Storage: 180×100
  * Start/End: 120×60
* Calculate text content and determine if scaling is needed
* Plan exact positions on 40px grid
* Verify minimum 80px spacing between elements

#### Step 3: Plan All Connections
* List every connection between elements
* Specify source and target for each connector
* Plan connector routing:
  * Which exit/entry points to use (top/bottom/left/right)
  * How many bends required (max 2)
  * Ensure orthogonal routing only
* Plan connector labels and their positions

#### Step 4: Collision Detection
* Check for element overlaps
* Check for connector-element intersections
* Check for connector-connector crossings
* Check for label-connector overlaps
* Check for label-element overlaps
* **If ANY collision detected**: Rearrange layout and repeat from Step 2

#### Step 5: Validation Checklist
Before proceeding to execution, verify:
- [ ] All positions are multiples of 40px
- [ ] Single flow direction used consistently
- [ ] Minimum 80px spacing between all elements
- [ ] All connectors are orthogonal
- [ ] No connector has more than 2 bends
- [ ] No crossings exist
- [ ] No overlaps of any kind
- [ ] All labels have 12-16px clearance
- [ ] Layout is balanced and symmetrical where possible

#### Step 6: Document the Plan
Write out the complete plan including:
* Element count and positions
* Connection count and routing
* Expected final dimensions
* Any special considerations

### 0.2 Execution Rules

**Only after Steps 1-6 are complete:**
* Begin creating elements in the draw.io tool
* Follow the plan exactly as documented
* Do not improvise or adjust during execution
* If an issue arises during execution, STOP and return to planning

### 0.3 Why Planning Is Mandatory

Without proper planning:
* Connectors cross each other
* Elements overlap
* Arrows connect to corners instead of centers
* Labels overlap with connectors or elements
* Layout becomes unreadable
* Multiple regeneration cycles are required

**Planning ensures the first execution is correct.**

---

## 1. Grid & Alignment

* Use a fixed grid with **40px spacing**
* All element positions and sizes must be multiples of **40px**
* All elements must be aligned horizontally and vertically

---

## 2. Flow Direction

* Use **only one global flow direction per diagram**:

  * **Top → Bottom**
  * **Left → Right**
* Never mix flow directions

---

## 3. Element Placement

* Elements are placed in **logical levels** (rows or columns)
* One level = one row (Top → Bottom) or one column (Left → Right)
* No element may be positioned between levels

## Adaptive Element Sizing (Auto-Scaling)

### 4. Element Sizes (Adaptive)

Each element has a **base size** and may scale **only if required by its content**.

#### Base Sizes

* **Process**: `160×80`
* **Decision**: `160×100`
* **Data / Storage**: `180×100`
* **Start / End**: `120×60`

These sizes are the **minimum allowed sizes**.

---

### 4.1 When Scaling Is Allowed

An element may increase its size **only if**:

* Text does not fit within the base size
* Text would wrap to more than **3 lines**
* Text would overlap padding or borders

---

### 4.2 Scaling Rules

* Scaling is allowed **only in steps of 40px**
* Width is scaled **before** height
* Maximum size increase:

  * Width: **+200% of base**
  * Height: **+150% of base**
* Scaling below base size is **not allowed**

---

### 4.3 Internal Padding

* Minimum internal padding: **16px**
* Text must never touch element borders
* Text must remain horizontally centered

---

### 4.4 Text Constraints

* Prefer concise text
* Avoid full sentences if possible
* If text exceeds scaling limits:

  * Summarize the text
  * Or split into multiple connected elements

---

### 4.5 Layout Reflow After Scaling

If an element is scaled:

* Recalculate spacing to preserve:

  * Minimum **80px** element spacing
  * Grid alignment
* Neighboring elements must shift, not overlap
* Connector routing must be recalculated

---

## Deterministic Decision Rule (Important)

When multiple valid layouts are possible:

1. Prefer **minimal element scaling**
2. Prefer **horizontal expansion over vertical**
3. Prefer **fewer connector bends**
4. Prefer **symmetry and alignment**

---

## Anti-Chaos Rule (Critical)

Do **not** compensate large text by:

* Breaking grid alignment
* Reducing spacing
* Allowing connector crossings
* Using diagonal connectors

The layout must remain structurally consistent.

---

## Updated Primary Objective

The diagram must:

* Adapt to content size
* Remain visually minimal
* Preserve structural rules
* Look intentional, not stretched


---

## 5. Spacing Rules

Minimum distances:

* Element ↔ Element: **80px**
* Parallel connectors: **24px**
* Connector ↔ Text: **12px**
* Connector ↔ Element boundary: **20px**

---

## 6. Connectors (Arrows)

* Use **orthogonal (elbow) connectors only**
* Diagonal or curved connectors are **not allowed**
* Maximum **2 bends per connector**
* Connectors must follow the global flow direction

---

## 7. Connector Routing Constraints

* A connector must **never intersect or overlap**:

  * Any element
  * Any text
  * Any other connector
* Connectors must not pass through element bounding boxes
* If a straight connector is blocked:

  * Add a single orthogonal bend
  * If still blocked, rearrange elements

---

## 8. Text Placement

* Text must **never overlap connectors**
* Connector labels must be placed:

  * Above the connector, or
  * Beside the connector
* Text must be offset from connectors by at least **12–16px**

---

## 9. Crossing Prohibition

* Connector crossings are **strictly forbidden**
* If a crossing would occur, the layout must be restructured

---

## 10. Validation Pass (Mandatory)

**Validation occurs in TWO phases:**

### Phase 1: During Planning (Section 0.4-0.5)
* Complete all checks before any execution
* Resolve all issues in the planning stage

### Phase 2: After Execution
Before finalizing the diagram, verify:

* No diagonal connectors
* No overlapping elements
* No connector/text overlap
* No connector crossings
* All positions align to the grid (40px multiples)
* Flow direction is consistent
* All elements connect center-to-center
* Labels have proper clearance (12-16px)
* Minimum spacing maintained (80px between elements)

If any check fails:
1. Document what failed
2. Return to Planning Phase (Section 0)
3. Regenerate the complete layout

---

## Primary Objective

The diagram must be:

* Human-readable
* Visually clean
* Deterministic and reproducible
* Easy to understand without additional explanation

---

## Workflow Summary

### Correct Workflow:
1. **PLAN** → Complete Section 0 (Planning Phase)
2. **VALIDATE** → Complete Section 0.5 (Validation Checklist)
3. **DOCUMENT** → Write out the complete plan
4. **EXECUTE** → Create elements following the plan exactly
5. **VERIFY** → Final validation pass (Section 10)

### Incorrect Workflow (DO NOT DO THIS):
❌ Start creating elements immediately
❌ Plan while executing
❌ Fix issues by adding more bends to connectors
❌ Adjust positions manually without grid alignment
❌ Hope that overlaps will resolve themselves

**Remember: 5 minutes of planning saves 30 minutes of regeneration.**