# cvi <img src="https://img.shields.io/badge/dev--version-0.0.0.9000-blue" align="right" height="25"/>

## Content Validity Index (CVI) Calculation Tools

The **cvi** package provides functions to compute the Content Validity Index (CVI) for items rated by multiple experts. It supports both item-level and scale-level CVI calculations, following widely used standards in educational, psychological, and health instrument validation.

---

### 🔧 Installation

You can install the development version of `cvi` from GitHub using:

```r
# install.packages("devtools")
devtools::install_github("jformoso/cvi")
```

---

### 🚀 Example

```r
library(cvi)

# Sample data
df <- data.frame(
  judge = c("A", "B", "C"),
  item1 = c(4, 3, 2),
  item2 = c(1, 4, NA),
  item3 = c(3, 2, 3)
)

# Calculate item-level CVI
item_cvi <- calculate_cvi(data = df, judge_id = "judge")

# Scale-level CVI (average method)
cvi_scale_ave(item_cvi)

# Scale-level CVI (universal agreement method)
cvi_scale_ua(item_cvi)
```

---

### 📘 Methods

- **Item-level CVI**: Proportion of experts rating an item as relevant (score 3 or 4).
- **Scale-level CVI (Average method)**: Average of item CVIs.
- **Scale-level CVI (Universal Agreement)**: Proportion of items with unanimous agreement (CVI = 1).

Acceptable CVI thresholds are applied based on the number of experts:
- 2 experts: CVI = 1
- 3–5 experts: CVI ≥ 0.83
- 6–8 experts: CVI ≥ 0.83
- ≥9 experts: CVI ≥ 0.78

The CVI methods implemented in this package follow recommendations from Yusoff (2019).

---

### 📚 References

Yusoff, M. S. B. (2019). ABC of content validation and content validity index calculation. *Education in Medicine Journal*, 11(2), 49–54. https://doi.org/10.21315/eimj2019.11.2.6

---

### 📄 License

MIT © Jesica Formoso
