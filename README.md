# A Complete and Natural Rule Set for Multi-Qudit Clifford Circuits in All Odd Prime Dimensions

This repository accompanies the paper [*A Complete and Natural Rule Set for Multi-Qudit Clifford Circuits in All Odd Prime Dimensions*](https://arxiv.org/pdf/2609.40106) by Xiaoning Bian, Sarah Meng Li, Neil J. Ross, John van de Wetering, and Yuming Zhao. It contains the Python code that checks the soundness of the box relations and derived relations used in the completeness proof, together with handwritten derivations of the box relations.

The paper presents 16 rewrite rules, (C0) to (C15) in Figure 1, and proves that they are sound and complete for $n$-qudit Clifford circuits over the generating set $\{-\omega, H, S, \mathrm{CZ}\}$ (Theorem 4.10). Here $p$ is an odd prime, $\omega = e^{2\pi i/p}$, and $g$ is a chosen generator of the multiplicative group $\mathbb{Z}_p^*$. The rules are stated using derived generators, such as the multiplier $M_g$, the Paulis $X$ and $Z$, SWAP, and CX, which are themselves circuits over $\{-\omega, H, S, \mathrm{CZ}\}$. Figure 2 shows a subset of them, and Figure 4 of the paper defines all of them, (T1) to (T9). The Agda formalisation of completeness is in a separate repository, [onestruggler/acir](https://github.com/onestruggler/acir/releases/tag/v1.0-quantum-submission).

As in the paper, everything in this repository is parametrised by the odd prime $p$. To check that a relation is sound, we show that its lefthand side and its righthand side have the same symplectic matrix over $\mathbb{Z}_p$, treating the parameters that appear in the relation (such as $a, b, c, d \in \mathbb{Z}_p$) as symbols rather than concrete numbers. In the notation of Definition 2.32 of the paper, this establishes $\mathrm{LHS} \equiv_s \mathrm{RHS}$. Each check is repeated for a list of odd primes.

In what follows, we explain how the repository relates to the proof, the folder structure, the verification method, the notations, and the conventions used in the code.

![](https://github.com/SarahMMMLi/QuditClifford/blob/main/Figures/Figure1.png)

![](https://github.com/SarahMMMLi/QuditClifford/blob/main/Figures/Figure2.png)

## Where This Fits in the Proof
The completeness proof in Section 4 of the paper has three steps.

1. **Box relations.** The symplectic normal form of Section 3.1 is built from the normal boxes $A$, $B$, $D$, and $E$ of Figure 6. Pushing a generator $H$, $S$, or CZ through one or two normal boxes yields a *box relation*. The 42 parametric box relations in Appendix F (Figures 15 to 21) suffice to rewrite any Clifford circuit into its symplectic normal form (Proposition 4.3).
2. **Relation reduction.** The 18 symplectic relations in Figure 9 imply all 42 box relations (Theorem 4.4). The reduction goes through a collection of *derived relations*, which serve as intermediate lemmas and are listed in the supplement *Derived Relations and Supplemental Proofs*. Handwritten proofs of this relation reduction are in [box-relation-reduction](https://github.com/SarahMMMLi/QuditClifford/tree/main/box-relation-reduction).
3. **Lifting.** Accounting for Pauli corrections (Propositions 4.8 and 4.9) and for the scalar $-\omega$ via (C0) lifts symplectic completeness to the unitary completeness of Figure 1 (Theorem 4.10).

For steps 1 and 2 to go through, the box relations and the derived relations must be sound up to Pauli correction, i.e. they must hold with respect to the symplectic interpretation of Definition 2.31. The notebooks in this repository check soundness in this sense. The soundness of the rules in Figure 1 as exact equalities of unitaries, scalars included, is proved by path-sum calculations in Appendix A.4 of the paper and is not checked here.

## Folder Structure
- [BoxRelation-Soundness.ipynb](https://github.com/SarahMMMLi/QuditClifford/blob/main/notebooks/BoxRelation-Soundness.ipynb) verifies the 66 one-, two-, and three-qudit box relations BR1 to BR66. Each box relation pushes a generator ($H$, $S$, or CZ) through one or two normal boxes ($A$, $B$, $D$, or $E$). These relations use an earlier parametrisation of the normal boxes than Figure 6 of the paper, which is why there are 66 of them rather than 42; see [Normal Boxes in the Code](#normal-boxes-in-the-code). The lefthand and righthand sides of every relation are exported as QASM files to [notebooks/circuits](https://github.com/SarahMMMLi/QuditClifford/tree/main/notebooks/circuits).
- [DerivedRelations-Soundness.ipynb](https://github.com/SarahMMMLi/QuditClifford/blob/main/notebooks/DerivedRelations-Soundness.ipynb) verifies the derived relations, organised into the families R1 to R21, C18, D2, and D3 (not every number in the range R1 to R21 has its own check). The QASM files are exported to [notebooks/derived-relations](https://github.com/SarahMMMLi/QuditClifford/tree/main/notebooks/derived-relations).
- [box-relation-derivations](https://github.com/SarahMMMLi/QuditClifford/tree/main/box-relation-derivations) contains all proofs deriving the one-, two-, and three-qudit box relations, organised into the subfolders [single-and-two-qudit](https://github.com/SarahMMMLi/QuditClifford/tree/main/box-relation-derivations/single-and-two-qudit) and [three-qudit](https://github.com/SarahMMMLi/QuditClifford/tree/main/box-relation-derivations/three-qudit).
- [box-relation-reduction](https://github.com/SarahMMMLi/QuditClifford/tree/main/box-relation-reduction) contains the handwritten proofs of the relation reduction (step 2 above), using the same BR numbering as [BoxRelation-Soundness.ipynb](https://github.com/SarahMMMLi/QuditClifford/blob/main/notebooks/BoxRelation-Soundness.ipynb). The one- and two-qudit derived relations are reduced in [one-qudit-relation-reduction.pdf](https://github.com/SarahMMMLi/QuditClifford/blob/main/box-relation-reduction/one-qudit-relation-reduction.pdf) and [two-qudit-relation-reduction.pdf](https://github.com/SarahMMMLi/QuditClifford/blob/main/box-relation-reduction/two-qudit-relation-reduction.pdf). The two-qudit box relations BR7 to BR39 are reduced in [two-qudit-box-relation-reduction.pdf](https://github.com/SarahMMMLi/QuditClifford/blob/main/box-relation-reduction/two-qudit-box-relation-reduction.pdf), and the three-qudit box relations that push CZ through two $B$ boxes or two $D$ boxes are reduced in [three-qudit-box-relation-reduction.pdf](https://github.com/SarahMMMLi/QuditClifford/blob/main/box-relation-reduction/three-qudit-box-relation-reduction.pdf). [summary-three-qudit-derived-relations.pdf](https://github.com/SarahMMMLi/QuditClifford/blob/main/box-relation-reduction/summary-three-qudit-derived-relations.pdf) lists the three-qudit derived relations.
- [Python-verification-convention.pdf](https://github.com/SarahMMMLi/QuditClifford/blob/main/notebooks/Python-verification-convention.pdf) records the symplectic matrix convention used in the code, the circuits implementing the $A$ boxes, and the sanity checks run on them.
- [dizx](https://github.com/SarahMMMLi/QuditClifford/tree/main/dizx) is the DiZX library for qudit ZX-calculus and circuit rewriting by Boldizsár Poór, Lia Yeh, and John van de Wetering (Apache 2.0). It is extended here with symbolic gate exponents, the QASM dialect described below, and the module [symplectic.py](https://github.com/SarahMMMLi/QuditClifford/blob/main/dizx/symplectic.py), which maps a Clifford circuit to its symplectic matrix.
- [Tests](https://github.com/SarahMMMLi/QuditClifford/tree/main/Tests) contains unit tests for the circuit simplifier in `dizx`.
- [Figures](https://github.com/SarahMMMLi/QuditClifford/tree/main/Figures) contains Figures 1 and 2 of the paper, shown above.

Scratch QASM exports and development notebooks for the `dizx` rewriting engine are kept in [circuits](https://github.com/SarahMMMLi/QuditClifford/tree/main/circuits), [notebooks/test](https://github.com/SarahMMMLi/QuditClifford/tree/main/notebooks/test), and [CircuitSimplifierHacking.ipynb](https://github.com/SarahMMMLi/QuditClifford/blob/main/notebooks/CircuitSimplifierHacking.ipynb). They are not needed to reproduce the soundness checks.

## Verification Method
Both soundness notebooks follow the same recipe. For each relation,

1. The lefthand side and the righthand side are built as `dizx` circuits. Parameters such as $a, b, c, d$ are SymPy symbols, and boxes and multipliers are instantiated by helper functions such as `instantiate_A_box` and `instantiate_multiplier`.
2. Each circuit is mapped to its symplectic matrix over $\mathbb{Z}_p$ via `Circuit.to_symplectic_matrix()`. Pauli gates map to the identity and phases are ignored, so a successful check establishes $\mathrm{LHS} \equiv_s \mathrm{RHS}$, i.e. the relation up to a Pauli correction and a global phase. The scalars appearing in Figures 1 and 2, such as $-\omega$, $\lambda_p$, and the Legendre symbol $\left(\frac{a}{p}\right)_L$, are not checked here.
3. The two matrices are reduced symbolically. Formal inverse pairs such as `(a, ainv)` and composite symbols such as `bminusc` are turned into polynomial relations (`a * ainv - 1`, `bminusc - (b - c)`, and so on), and the matrix entries are reduced with respect to a Gröbner basis of these relations. This is what allows the check to be symbolic in the parameters.
4. The reduced matrices are taken modulo $p$ and compared entrywise.

This is repeated for every prime in a list such as `primes = [3, 5, 7, 11, 13, 19, 23, 31, 37]`. The notebook prints ✔ if the relation holds for a prime and ❌ otherwise. After all primes have been processed, the lefthand and righthand circuits are written to QASM files for the last prime in the list.

Note that the soundness of a relation never depends on order relations such as $S^p = \mathrm{CZ}^p = I$. It only relies on field identities such as $(b - a)(b - a)^{-1} = 1$, so in principle a single prime would suffice. We iterate over several primes as a sanity check.

## Notations
We follow the notation of the paper. The abbreviations and code-specific names are summarised below.

- $p$ is the qudit dimension, an odd prime, $\omega = e^{2\pi i/p}$, and $\lambda_p = e^{(p-1)\pi i/4}$. In the code, $p$ is the argument `p` or `dim`, and the line `quditdim p` in a QASM file.
- $g$ is a chosen generator of $\mathbb{Z}_p^*$, and $M_a$ is the multiplier by $a \in \mathbb{Z}_p^*$ (Definition 2.14), which sends $\vert x\rangle$ to $\vert ax\rangle$.
- $\equiv$, $\equiv_u$, $\equiv_p$, and $\equiv_s$ are the equivalences of Definition 2.32: equal as circuits, equal as unitaries, equal up to a global phase, and equal up to a Pauli correction (same symplectic matrix). The code checks $\equiv_s$. The handwritten notes write $\hat{=}$ for $\equiv_s$.
- **LHS** is short for 'Lefthand Side' and **RHS** is short for 'Righthand Side'.
- $A_{ab}$, $B_{ab}$, $D_{ab}$, and $E_b$ denote the normal boxes, with parameters in $\mathbb{Z}_p$.
- **BR** followed by a number denotes a box relation as numbered in [BoxRelation-Soundness.ipynb](https://github.com/SarahMMMLi/QuditClifford/blob/main/notebooks/BoxRelation-Soundness.ipynb), e.g. **BR10**. This numbering is internal to the repository and differs from the order of the box relations in Appendix F of the paper.
- **R**, **D**, or **C18** followed by a number denotes a derived relation, e.g. **R9** or **C18-17**. **D2** and **D3** express the $A$ boxes in terms of multipliers. The **C18** family consists of instances and variants of relation (C18) in Figure 9, which is the same circuit identity as (C15) in Figure 1. Note that Figure 9 and Figure 1 number their relations differently, even though both use labels starting with C. The handwritten [summary of three-qudit derived relations](https://github.com/SarahMMMLi/QuditClifford/blob/main/box-relation-reduction/summary-three-qudit-derived-relations.pdf) follows Figure 1 and labels the variants of this relation $C_{15}^1$ to $C_{15}^{14}$.
- Exponents of $\omega$ and of gates of order $p$ are read in $\mathbb{Z}_p$ (Remarks 1.1 and 2.2). For example, $S^{a^{-1}}$ is an integer power of $S$, and $S^{-1}$ is $S^{p-1}$.
- In the code, the formal inverse of a symbol `x` is written `xinv`, and composite parameters are spelled out in words: `ainv` is $a^{-1}$, `binvinv` is $(b^{-1})^{-1}$, `bminusc` is $b - c$, `oneminusa` is $1 - a$, `aplus1` is $a + 1$, `ab` is $ab$, and `ac` is $ac$.

## Conventions
- **Symplectic matrices.** The paper (Definition 2.26) identifies an $n$-qudit Pauli, up to phase, with a vector $(\vec{a}, \vec{b}) \in \mathbb{Z}_p^{2n}$, where $\vec{a}$ collects the $Z$ exponents and $\vec{b}$ the $X$ exponents. The code instead orders the coordinates qudit by qudit as $(x_1, z_1, x_2, z_2, \dots, x_n, z_n)$, with the $X$ exponent before the $Z$ exponent. The matrix of a circuit $C$ sends the exponent vector of a Pauli $P$ to that of $C \bullet P = CPC^\dagger$. The two orderings differ by a fixed permutation of the coordinates, so two circuits have the same matrix in one convention if and only if they have the same matrix in the other, and the soundness checks are unaffected. The matrices of the individual gates agree with Lemma 2.24 ($H$ and $S$), Lemma 2.25 (CZ), Lemma B.3 (CX), and Equation (12) ($M_a$). For example, $H$ sends $X$ to $Z$ and $Z$ to $X^{-1}$, so its matrix in the basis $(x, z)$ has columns $(0, 1)$ and $(-1, 0)$. See [Python-verification-convention.pdf](https://github.com/SarahMMMLi/QuditClifford/blob/main/notebooks/Python-verification-convention.pdf) for worked examples.
- **Circuit order.** Gates are listed in the order in which they are applied, which is the diagrammatic order $A;B$ of Section 3.3 of the paper. The circuit $A;B$ corresponds to the matrix product $BA$, and `Circuit.to_symplectic_matrix()` multiplies accordingly.
- Every relation is stored as a pair of QASM files named `<name>-lhs.qasm` and `<name>-rhs.qasm`.
- A numeric suffix such as `-2` or `-3` marks a case split of the same relation. For example, `BR10-2` is the second case of BR10. Names such as `R9-12` or `C18-17-3` enumerate instantiations of a relation family.
- The QASM dialect extends OPENQASM 2.0 with a `quditdim p` line that fixes the dimension $p$. The available gates are `h`, `s`, `cz`, `cx`, and `swap`. A gate can be raised to an integer or symbolic power with `^`, for example `h^-1`, `s^b`, `s^binv`, `cx^a`, or `cx^-binv*c`.
- For `cx q[i], q[j]`, the first argument is the control and the second is the target, as in (T5) of the paper. The gate XC of (T6) is written `cx` with the control and target swapped.
- Qudit indices start from 0, and the qudit with index 0 is the top wire in the circuit diagrams of the paper.

Here is an example. The relation `C18-1` is an instance of (C18) in Figure 9, i.e. (C15) in Figure 1, with a CX gate raised to the power $a$: a CX gate with control 0 and target 1 commutes past a CZ gate on qudits 1 and 2 at the cost of an extra CZ on qudits 0 and 2.

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

## Normal Boxes in the Code
The box relations BR1 to BR66, the handwritten proofs in [box-relation-derivations](https://github.com/SarahMMMLi/QuditClifford/tree/main/box-relation-derivations) and [box-relation-reduction](https://github.com/SarahMMMLi/QuditClifford/tree/main/box-relation-reduction), and [Python-verification-convention.pdf](https://github.com/SarahMMMLi/QuditClifford/blob/main/notebooks/Python-verification-convention.pdf) use an earlier parametrisation of the normal boxes than Figure 6 of the paper. The table compares the two. Circuits are read from left to right, and on two qudits the "top" wire is the first qudit $j$ and the "bottom" wire is the second qudit $k$.

| Box | Figure 6 of the paper | Code (`instantiate_*_box`) | Same symplectic matrix? |
| --- | --- | --- | --- |
| $A_{0b}$, $b \neq 0$ | $M_b$ | $H^{-1}, S^{b^{-1}}, H^{-1}, S^{b}, H$ | No |
| $A_{ab}$, $a \neq 0$ | $S^{-b/a}, H, M_a$ | $H^{-1}, S^{-a}, H^{-1}, S^{-a^{-1}}, H^{-1}, S^{-a(b+1)}, H$ | Yes |
| $B_{00}$ | SWAP | SWAP | Yes |
| $B_{01}$ | CX, SWAP | SWAP, XC | Yes |
| $B_{0b}$, $b \notin \{0, 1\}$ | $\mathrm{CX}^b$, SWAP | $A_{0b}$ on top, SWAP, XC | No |
| $B_{ab}$, $a \neq 0$ | $S^{-b/a}$ and $H$ on top, $\mathrm{CX}^a$, SWAP | $A_{ab}$ on top, SWAP, XC | Not in general |
| $D_{0b}$ | $\mathrm{CZ}^{-b}$, SWAP | SWAP, $\mathrm{CZ}^{-b}$ | Yes |
| $D_{ab}$, $a \neq 0$ | $S^{-b/a}$ and $H$ on the bottom, $\mathrm{CZ}^{-a}$, SWAP | $A_{ab}$ on the bottom, SWAP, $\mathrm{CZ}^{-1}$ | Not in general |
| $E_b$ | $S^{-b}$ | $S^{-b}$ | Yes |

Because some boxes differ, BR1 to BR66 are checked for this earlier parametrisation and do not correspond one-to-one to the 42 parametric box relations in Appendix F of the paper. For example, the code treats $B_{01}$ and $B_{0b}$ with $b \notin \{0, 1\}$ as separate cases. We deliberately keep the soundness check for this previous version of the box relations, so that it matches the handwritten derivations in this repository.

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
