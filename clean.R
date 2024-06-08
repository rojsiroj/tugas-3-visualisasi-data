library(readxl)
library(dplyr)

# Memuat dataset
dataset <- read_excel("DataSet Tugas 3- MSIM4310.xls")

# Tampilkan beberapa baris pertama kumpulan data untuk memahami strukturnya
print(head(dataset))

# Periksa nilai yang hilang / missing
print(sapply(dataset, function(x) sum(is.na(x))))

# Bersihkan dataset jika perlu
# Misalnya, hapus baris dengan nilai yang hilang
cleaned_dataset <- na.omit(dataset)

# Simpan kumpulan data yang telah dibersihkan untuk digunakan di aplikasi Shiny
write.csv(cleaned_dataset, "cleaned_dataset.csv", row.names = FALSE)
