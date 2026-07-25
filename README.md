# rising-edge-detector-fsm
Verilog HDL implementation of rising edge detectors using both Moore and Mealy finite state machines, including a shared testbench for behavioral comparison and simulation.


# Rising Edge Detector using Moore and Mealy FSM

## Overview

This project implements a digital rising edge detector in Verilog HDL using two different finite state machine (FSM) architectures:

- Moore FSM
- Mealy FSM

Both implementations detect a low-to-high transition (`0 → 1`) on the input signal and generate a one-clock pulse (`tick`). The project also includes a common testbench that compares the behavior of both designs under identical input conditions.

---

## Project Objectives

- Design a Rising Edge Detector using a Moore FSM.
- Design the same detector using a Mealy FSM.
- Compare the behavior of both architectures.
- Verify functionality through simulation.

---



# Moore FSM

The Moore implementation generates the output according to the current state only.

The detector uses three states.

| State | Description |
|-------|-------------|
| ZERO | Input is Low |
| EDGE | Rising edge detected |
| ONE | Input remains High |

---



## Moore Operation

```
Input = 0
      ↓
ZERO

Input becomes 1
      ↓
EDGE

Next Clock
      ↓
ONE

Input becomes 0
      ↓
ZERO
```

The output pulse is generated only while the FSM is in the **EDGE** state.

---

# Mealy FSM

The Mealy implementation generates the output using both the current state and the input.

Only two states are required.

| State | Description |
|-------|-------------|
| ZERO | Input Low |
| ONE | Input High |



## Mealy Operation

```
ZERO
 │
 │ level = 1
 ▼
ONE
```

The output pulse is generated immediately when:

```
present_state = ZERO

AND

level = 1
```

without waiting for the next clock cycle.

---

# Moore vs Mealy

| Feature | Moore | Mealy |
|---------|--------|--------|
| Output depends on | State | State + Input |
| Number of States | 3 | 2 |
| Response Time | Next clock edge | Immediate |
| Output Stability | Higher | Faster response |

---

# Input Signals

| Signal | Direction | Description |
|---------|-----------|-------------|
| clk | Input | System clock |
| reset | Input | Asynchronous reset |
| level | Input | Signal being monitored |

---

# Output Signal

| Signal | Description |
|---------|-------------|
| tick | One-clock pulse indicating a rising edge |

---

# Simulation and Verification

The included testbench stimulates both detectors simultaneously.

The following scenarios are verified.

---

## Scenario 1 — Reset

Expected behavior:

```
reset = 1

↓

Moore → ZERO

Mealy → ZERO

tick = 0
```

---

## Scenario 2 — First Rising Edge

Input sequence

```
level

0

↓

1
```

Expected behavior

### Moore

```
ZERO

↓

EDGE

↓

ONE
```

A one-clock pulse is generated while the FSM enters the **EDGE** state.

### Mealy

```
ZERO

↓

ONE
```

The output pulse is generated immediately during the transition.

### Simulation Waveform


---

## Scenario 3 — Input Remains High

```
level = 1
```

Expected behavior

```
tick = 0
```

for both implementations.

### Simulation Waveform



---

## Scenario 4 — Falling Edge

```
level

1

↓

0
```

Expected behavior

```
tick = 0
```

The falling edge does not generate an output pulse.

### Simulation Waveform


---

## Scenario 5 — Second Rising Edge

The detector is stimulated with another rising edge.

Expected behavior

### Moore

```
ZERO

↓

EDGE

↓

ONE
```

### Mealy

```
ZERO

↓

ONE
```

Both detectors generate a new pulse.





---
