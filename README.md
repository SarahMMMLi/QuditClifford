# A Complete and Natural Rule Set for Multi-Qudit Clifford Circuits in All Odd Prime Dimensions

This repository contains the Python verification code accompanying the paper. The paper presents a complete set of 16 rewrite rules, (C0) to (C15), for $n$-qudit Clifford circuits over the generating set $\{H, S, \mathrm{CZ}\}$, where the qudit dimension $d$ is an odd prime and $g$ is a chosen generator of the multiplicative group $\mathbb{Z}_d^*$. The rules are stated using a handful of derived generators, such as the multiplier $M_g$, the Paulis $X$ and $Z$, SWAP, and CX, which are themselves defined as circuits over $\{H, S, \mathrm{CZ}\}$.

Rather than fixing a single dimension, everything in this repository is parametrised by an odd prime $p$ (we write $p$ for $d$ throughout the code). To check that a relation is sound, we show that its lefthand side and its righthand side have the same symplectic matrix over $\mathbb{Z}_p$, treating the parameters that appear in the relation (such as $a, b, c, d \in \mathbb{Z}_p$) as symbols rather than concrete numbers. Each check is repeated for a list of odd primes.

In what follows, we explain the folder structure, the verification method, the notations, and the conventions used in the code.

![](https://github.com/SarahMMMLi/QuditClifford/blob/main/Figures/Figure1.png)

![](https://github.com/SarahMMMLi/QuditClifford/blob/main/Figures/Figure2.png)

## Folder Structure
The completeness proof in the paper proceeds in two stages. First, the box relations in the appendix are shown to be consequences of a set of derived relations. Second, the derived relations are shown to be consequences of the rewrite rules in Figure 1. For this argument to go through, both the box relations and the derived relations must be sound, i.e. they must hold as equalities of Clifford operators. This repository checks the soundness of both.

- [BoxRelation-Soundness.ipynb](https://github.com/SarahMMMLi/QuditClifford/blob/main/notebooks/BoxRelation-Soundness.ipynb) verifies the 66 one-, two-, and three-qupit box relations BR1 to BR66. Each box relation pushes a generator ($H$, $S$, or CZ) through one or two boxes ($A$, $B$, $D$, or $E$) of the normal form. The lefthand and righthand sides of every relation are exported as QASM files to [notebooks/circuits](https://github.com/SarahMMMLi/QuditClifford/tree/main/notebooks/circuits).
- [DerivedRelations-Soundness.ipynb](https://github.com/SarahMMMLi/QuditClifford/blob/main/notebooks/DerivedRelations-Soundness.ipynb) verifies the derived relations, organised into the families R1 to R21 and C18. The QASM files are exported to [notebooks/derived-relations](https://github.com/SarahMMMLi/QuditClifford/tree/main/notebooks/derived-relations).
- [dizx](https://github.com/SarahMMMLi/QuditClifford/tree/main/dizx) is the DiZX library for qudit ZX-calculus and circuit rewriting by Boldizsár Poór, Lia Yeh, and John van de Wetering (Apache 2.0). It is extended here with symbolic gate exponents, the QASM dialect described below, and the module [symplectic.py](https://github.com/SarahMMMLi/QuditClifford/blob/main/dizx/symplectic.py), which maps a Clifford circuit to its symplectic matrix.
- [Tests](https://github.com/SarahMMMLi/QuditClifford/tree/main/Tests) contains unit tests for the circuit simplifier in `dizx`.
- [Figures](https://github.com/SarahMMMLi/QuditClifford/tree/main/Figures) contains Figures 1 and 2 above.

Scratch QASM exports and development notebooks for the `dizx` rewriting engine are kept in [circuits](https://github.com/SarahMMMLi/QuditClifford/tree/main/circuits), [notebooks/test](https://github.com/SarahMMMLi/QuditClifford/tree/main/notebooks/test), and [CircuitSimplifierHacking.ipynb](https://github.com/SarahMMMLi/QuditClifford/blob/main/notebooks/CircuitSimplifierHacking.ipynb). They are not needed to reproduce the soundness checks.

## Verification Method
Both soundness notebooks follow the same recipe. For each relation,

1. The lefthand side and the righthand side are built as `dizx` circuits. Parameters such as $a, b, c, d$ are SymPy symbols, and boxes are instantiated by helper functions such as `instantiate_A_box` and `instantiate_multiplier`.
2. Each circuit is mapped to its symplectic matrix over $\mathbb{Z}_p$ via `Circuit.to_symplectic_matrix()`. The matrix acts on the basis $(x_1, z_1, x_2, z_2, \dots)$. Phases are ignored, so a successful check establishes the relation up to Paulis and a global scalar. The scalars appearing in Figures 1 and 2, such as $\omega$, $\lambda_d$, and the Legendre symbol, are not checked here.
3. The two matrices are reduced symbolically. Formal inverse pairs such as `(a, ainv)` and composite symbols such as `bminusc` are turned into polynomial relations (`a * ainv - 1`, `bminusc - (b - c)`, and so on), and the matrix entries are reduced with respect to a Gröbner basis of these relations. This is what allows the check to be symbolic in the parameters.
4. The reduced matrices are taken modulo $p$ and compared entrywise.

This is repeated for every prime in the list `primes = [3, 5, 7, 11, 13, 19, 23, 31, 37]`. The notebook prints ✔ if the relation holds for a prime and ❌ otherwise. After all primes have been processed, the lefthand and righthand circuits are written to QASM files for the last prime in the list.

Note that the soundness of a relation never depends on order relations such as $S^p = \mathrm{CZ}^p = I$. It only relies on field identities such as $(b - a)(b - a)^{-1} = 1$, so in principle a single prime would suffice. We iterate over several primes as a sanity check.

## Notations
We use a few abbreviations to simplify the discussions, as summarized below.

- **LHS** is short for 'Lefthand Side'.
- **RHS** is short for 'Righthand Side'.
- **BR** followed by a number denotes a box relation from the appendix of the paper, e.g. **BR10**.
- **R** or **C18** followed by a number denotes a derived relation, e.g. **R9** or **C18-17**.
- $A_{ab}$, $B_{ab}$, $D_{ab}$, and $E_b$ denote the boxes of the normal form, with parameters in $\mathbb{Z}_p$. $M_a$ denotes the multiplier gate.
- In the code, the formal inverse of a symbol `x` is written `xinv`, and composite parameters are spelled out in words: `ainv` is $a^{-1}$, `binvinv` is $(b^{-1})^{-1}$, `bminusc` is $b - c$, `oneminusa` is $1 - a$, `aplus1` is $a + 1$, `ab` is $ab$, and `ac` is $ac$.

## Conventions
- Every relation is stored as a pair of QASM files named `<name>-lhs.qasm` and `<name>-rhs.qasm`.
- A numeric suffix such as `-2` or `-3` marks a case split of the same relation. For example, `BR10-2` is the second case of BR10. Names such as `R9-12` or `C18-17-3` enumerate instantiations of a relation family.
- The QASM dialect extends OPENQASM 2.0 with a `quditdim p` line that fixes the dimension. The available gates are `h`, `s`, `cz`, `cx`, and `swap`. A gate can be raised to an integer or symbolic power with `^`, for example `h^-1`, `s^b`, `s^binv`, `cx^a`, or `cx^-binv*c`.
- For `cx q[i], q[j]`, the first argument is the control and the second is the target.
- Qudit indices start from 0, and gates are listed in the order in which they are applied.

Here is an example. The relation `C18-1` states that a CX gate with control 0 and target 1 commutes past a CZ gate on qudits 1 and 2 at the cost of an extra CZ.

`C18-1-lhs.qasm`
```
OPENQASM 2.0;
include "qelib1.inc";
quditdim 37
qreg q[3];
cx^a q[0], q[1];
cz q[1], q[2];
```

`C18-1-rhs.qasm`
```
OPENQASM 2.0;
include "qelib1.inc";
quditdim 37
qreg q[3];
cz q[1], q[2];
cx^a q[0], q[1];
cz^a q[0], q[2];
```

## Running the Code
The notebooks require Python 3 together with SymPy, NumPy, Matplotlib, ipywidgets, Qiskit (only for drawing circuits), and Jupyter.

```
pip install sympy numpy matplotlib ipywidgets qiskit jupyter
cd notebooks
jupyter notebook
```

Open either soundness notebook and run all cells. The unit tests for the circuit simplifier can be run from the repository root.

```
python -m unittest Tests/test_clifford_simp.py
```
