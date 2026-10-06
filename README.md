# A Complete and Natural Rule Set for Multi-Qudit Clifford Circuits in All Odd Prime Dimensions

This repository accompanies the paper [*A Complete and Natural Rule Set for Multi-Qudit Clifford Circuits in All Odd Prime Dimensions*](https://arxiv.org/pdf/2609.40106) by Xiaoning Bian, Sarah Meng Li, Neil J. Ross, John van de Wetering, and Yuming Zhao. The paper proves that the 16 rewrite rules in Figure 1 are sound and complete for $n$-qudit Clifford circuits over $\{-\omega, H, S, \mathrm{CZ}\}$, for every odd prime $p$ (Theorem 4.10). Figure 2 defines some of the derived generators used in the rules. The Agda formalisation is in [onestruggler/acir](https://github.com/onestruggler/acir/releases/tag/v1.0-quantum-submission).

![](https://github.com/SarahMMMLi/QuditClifford/blob/main/Figures/Figure1.png)

![](https://github.com/SarahMMMLi/QuditClifford/blob/main/Figures/Figure2.png)

## Previous Normal Boxes
The paper builds its normal form from the normal boxes in Figure 6, which yield 42 box relations (Appendix F). This repository uses a previous construction of the boxes $A$, $B$, and $D$, which yields 66 box relations, BR1 to BR66. All handwritten proofs and soundness checks here use these previous boxes. [previous-normal-boxes.pdf](https://github.com/SarahMMMLi/QuditClifford/blob/main/previous-normal-boxes.pdf) records the boxes, their action on the Pauli generators, and BR1 to BR66.

With these boxes, the repository follows the same proof steps as the paper.

## Proof Steps and Where to Find Them
1. **Box relations.** Pushing $H$, $S$, or CZ through one or two normal boxes gives a box relation. The box relations rewrite any Clifford circuit into its symplectic normal form (Proposition 4.3).
   - Derivations: [box-relation-derivations](https://github.com/SarahMMMLi/QuditClifford/tree/main/box-relation-derivations)
   - Soundness check: [BoxRelation-Soundness.ipynb](https://github.com/SarahMMMLi/QuditClifford/blob/main/notebooks/BoxRelation-Soundness.ipynb), with QASM exports in [notebooks/circuits](https://github.com/SarahMMMLi/QuditClifford/tree/main/notebooks/circuits)
2. **Relation reduction.** The box relations follow from the symplectic relations in Figure 9 (Theorem 4.4), via intermediate *derived relations* listed in the [supplement](https://arxiv.org/src/2609.40106v1/anc/supplement.pdf).
   - Proofs: [box-relation-reduction](https://github.com/SarahMMMLi/QuditClifford/tree/main/box-relation-reduction), covering the one- and two-qudit derived relations, the two-qudit box relations BR7 to BR39, and the three-qudit box relations. [summary-three-qudit-derived-relations.pdf](https://github.com/SarahMMMLi/QuditClifford/blob/main/box-relation-reduction/summary-three-qudit-derived-relations.pdf) lists the three-qudit derived relations.
   - Soundness check: [DerivedRelations-Soundness.ipynb](https://github.com/SarahMMMLi/QuditClifford/blob/main/notebooks/DerivedRelations-Soundness.ipynb), with QASM exports in [notebooks/derived-relations](https://github.com/SarahMMMLi/QuditClifford/tree/main/notebooks/derived-relations)
3. **Phaseful relation reduction.** The lifted relations, i.e. the Pauli- and phase-corrected versions of the relations in Figure 9, follow from Figure 1. This lifts completeness from symplectic matrices to exact unitaries (Theorem 4.10).
   - Part I: the [supplement](https://arxiv.org/src/2609.40106v1/anc/supplement.pdf)
   - Part II: [phaseful-relation-reduction-part-2.pdf](https://github.com/SarahMMMLi/QuditClifford/blob/main/phaseful-relation-reduction/phaseful-relation-reduction-part-2.pdf), which also derives three rules of an earlier, 19-rule version of Figure 1 from the remaining rules

Appendix A of the paper proves, using path sums, that the rules in Figure 1 hold as exact unitaries. [soundness-from-path-sum.pdf](https://github.com/SarahMMMLi/QuditClifford/blob/main/phaseful-relation-reduction/soundness-from-path-sum.pdf) gives extended versions of these calculations.

## Other Contents
- [Python-verification-convention.pdf](https://github.com/SarahMMMLi/QuditClifford/blob/main/notebooks/Python-verification-convention.pdf): the symplectic convention used in the code, with sanity checks.
- [dizx](https://github.com/SarahMMMLi/QuditClifford/tree/main/dizx): the DiZX library by Boldizsár Poór, Lia Yeh, and John van de Wetering (Apache 2.0), extended with symbolic gate exponents, a qudit QASM dialect, and [symplectic.py](https://github.com/SarahMMMLi/QuditClifford/blob/main/dizx/symplectic.py), which maps a Clifford circuit to its symplectic matrix.
- [Tests](https://github.com/SarahMMMLi/QuditClifford/tree/main/Tests): unit tests for the circuit simplifier in `dizx`.
- [Figures](https://github.com/SarahMMMLi/QuditClifford/tree/main/Figures): Figures 1 and 2 of the paper.
- [circuits](https://github.com/SarahMMMLi/QuditClifford/tree/main/circuits), [notebooks/test](https://github.com/SarahMMMLi/QuditClifford/tree/main/notebooks/test), and [CircuitSimplifierHacking.ipynb](https://github.com/SarahMMMLi/QuditClifford/blob/main/notebooks/CircuitSimplifierHacking.ipynb): scratch files, not needed for the soundness checks.

## How the Soundness Checks Work
Both notebooks check each relation as follows.

1. Build the lefthand side (LHS) and righthand side (RHS) as `dizx` circuits, with parameters such as $a, b, c, d$ as SymPy symbols.
2. Map each circuit to its symplectic matrix over $\mathbb{Z}_p$ with `Circuit.to_symplectic_matrix()`. Paulis and phases are ignored, so a match shows $\mathrm{LHS} \equiv_s \mathrm{RHS}$ (Definition 2.32): equality up to a Pauli correction and a global phase.
3. Reduce the entries with a Gröbner basis of relations such as `a * ainv - 1` and `bminusc - (b - c)`, so that the check is symbolic in the parameters.
4. Compare the matrices modulo $p$.

Each check runs over a list of primes such as `[3, 5, 7, 11, 13, 19, 23, 31, 37]` and prints ✔ or ❌ for each prime. The QASM files are written for the last prime. Soundness only uses field identities such as $(b - a)(b - a)^{-1} = 1$, so one prime would suffice; the others are a sanity check.

## Notation and Conventions
We follow the notation of the paper: $p$ is an odd prime, $\omega = e^{2\pi i/p}$, $\lambda_p = e^{(p-1)\pi i/4}$, $g$ generates $\mathbb{Z}_p^*$, and $M_a$ is the multiplier $\vert x\rangle \mapsto \vert ax\rangle$. Exponents of $\omega$ and of gates of order $p$ are read in $\mathbb{Z}_p$; for example, $S^{a^{-1}}$ is an integer power of $S$.

**Handwritten notes.** $\hat{=}$ means $\equiv_s$. The notes in [phaseful-relation-reduction](https://github.com/SarahMMMLi/QuditClifford/tree/main/phaseful-relation-reduction) write $d$ for $p$ and $\lambda_d$ for $\lambda_p$. Part II numbers the rules after the earlier 19-rule Figure 1, shown on its first page.

**Relation names.**
- BR1 to BR66 are the box relations, numbered as in [previous-normal-boxes.pdf](https://github.com/SarahMMMLi/QuditClifford/blob/main/previous-normal-boxes.pdf), not as in Appendix F.
- R, D, or C18 followed by a number is a derived relation, e.g. R9 or C18-17. D2 and D3 express the $A$ boxes using multipliers. C18 refers to (C18) in Figure 9, which is (C15) in Figure 1; [summary-three-qudit-derived-relations.pdf](https://github.com/SarahMMMLi/QuditClifford/blob/main/box-relation-reduction/summary-three-qudit-derived-relations.pdf) labels its variants $C_{15}^1$ to $C_{15}^{14}$.
- A suffix such as `-2` marks a case split (`BR10-2` is the second case of BR10). Names such as `R9-12` or `C18-17-3` are instances of a family.

**Code.**
- `xinv` is $x^{-1}$, and composite parameters are spelled out: `bminusc` is $b - c$, `oneminusa` is $1 - a$, `aplus1` is $a + 1$, and `binvinv` is $(b^{-1})^{-1}$.
- Symplectic matrices use the coordinates $(x_1, z_1, \dots, x_n, z_n)$ and send the exponents of a Pauli $P$ to those of $CPC^\dagger$. The paper (Definition 2.26) lists all $Z$ exponents before all $X$ exponents. The two orderings differ by a fixed permutation, so the checks are unaffected. The gate matrices agree with Lemmas 2.24, 2.25, and B.3 and Equation (12).
- Gates are listed in the order in which they are applied: the paper's $A;B$, i.e. the matrix $BA$.

**QASM files.** Each relation is stored as `<name>-lhs.qasm` and `<name>-rhs.qasm`. The dialect extends OPENQASM 2.0 with a `quditdim p` line and the gates `h`, `s`, `cz`, `cx`, and `swap`, which take integer or symbolic powers such as `s^binv` or `cx^-binv*c`. In `cx q[i], q[j]`, `q[i]` is the control; XC is `cx` with the arguments swapped. Qudit 0 is the top wire.

For example, `C18-1` is a parametrised instance of (C15) in Figure 1.

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
The notebooks require Python 3 with SymPy, NumPy, Matplotlib, ipywidgets, Qiskit (only for drawing circuits), and Jupyter.

```
pip install sympy numpy matplotlib ipywidgets qiskit jupyter
cd notebooks
jupyter notebook
```

Open either soundness notebook and run all cells. To run the unit tests for the circuit simplifier, run the following from the repository root.

```
python -m unittest Tests/test_clifford_simp.py
```
