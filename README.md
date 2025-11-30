# IT4593 - So sánh các biến thể Differential Evolution (DE) trên hàm Rastrigin

Repository này chứa mã nguồn MATLAB dùng để chạy và so sánh độ hội tụ của các biến thể thuật toán Differential Evolution: `DE/rand/1`, `DE/best/1`, `DE/current-to-best/1`, và `jDE` trên hàm benchmark Rastrigin đa chiều.

## Mục tiêu

- Minh họa sự khác nhau về tốc độ và chất lượng hội tụ giữa các chiến lược DE.
- Ghi nhận giá trị fitness tốt nhất qua từng thế hệ (generation).
- Cung cấp khung mở rộng thêm hàm benchmark hoặc biến thể DE khác.

## Cấu trúc thư mục

- `src/` : Các hàm và script chính (`main_compare.m`, `rastrigin.m`, các hàm DE, ví dụ `main.m`).
- `tests/` : Script kiểm thử đơn giản (`test_main.m`).

## Tham số trong `main_compare.m`

- `func` : Hàm mục tiêu (ở đây là `@rastrigin`).
- `D` : Số chiều (3).
- `lb`, `ub` : Cận dưới / trên (−5.12 / 5.12) chuẩn cho Rastrigin.
- `NP` : Kích thước quần thể (population size) = 50.
- `F` : Hệ số khuếch đại (mutation scale) = 0.8.
- `Cr` : Tỉ lệ lai ghép (crossover rate) = 0.9.
- `Gmax` : Số thế hệ tối đa (1000, có thể tăng lên 1500 để hội tụ tốt hơn).

## Mô tả nhanh các biến thể DE

- `DE/rand/1` : Chiến lược cổ điển, mutation từ 3 cá thể ngẫu nhiên.
- `DE/best/1` : Khai thác mạnh quanh cá thể tốt nhất hiện tại.
- `DE/current-to-best/1` : Kết hợp khai thác và thăm dò hướng tới best.
- `jDE` : Tự điều chỉnh (self-adaptive) các tham số F và Cr trong quá trình tiến hóa.

## Hướng dẫn chạy (PowerShell / CMD)

1. Đảm bảo MATLAB đã cài (đã phát hiện `R2025b`).
1. Chạy script so sánh chính:

```powershell
Push-Location "C:\Users\An\Documents\IT4593-KTTT\project"
& "C:\Program Files\MATLAB\R2025b\bin\matlab.exe" -batch "addpath('src'); run('src/main_compare.m')"
Pop-Location
```

1. Tùy chọn: thêm MATLAB vào PATH để gõ ngắn gọn hơn:

```powershell
$matlabBin = "C:\Program Files\MATLAB\R2025b\bin"
[Environment]::SetEnvironmentVariable("Path", $Env:Path + ";" + $matlabBin, "User")
$Env:Path = $Env:Path + ";" + $matlabBin
matlab -batch "addpath('src'); run('src/main_compare.m')"
```

1. Chạy qua MATLAB GUI: mở MATLAB, đặt Current Folder tới thư mục dự án, rồi chạy:

```matlab
addpath('src');
run('src/main_compare.m')
```

## Kết quả mẫu (đã quan sát)

```text
---- Final fbest values ----
DE/rand/1 best fitness: 0.0000000000
DE/best/1 best fitness: 3.9798311906
DE/current-to-best/1 best fitness: 0.0000456471
jDE best fitness: 0.0000000000
```

Giá trị 0 gần tối ưu toàn cục của Rastrigin (f = 0 tại vectơ 0). Sự khác nhau phản ánh khả năng khai thác / thăm dò của từng biến thể.

## Mở rộng

- Thêm hàm benchmark: tạo file ví dụ `sphere.m`, `ackley.m` rồi đổi `func = @ackley;`.
- Lưu biểu đồ: thêm dòng `saveas(gcf,'outputs/convergence.png');` (tạo thư mục `outputs/`).
- Ghi log chi tiết: lưu lịch sử vào `.mat` để phân tích sau.

## Yêu cầu

- MATLAB R2021b+ (ưu tiên R2025b như đã phát hiện).
- Không cần toolbox nâng cao cho ví dụ này.

## Ghi chú

- Có thể tinh chỉnh `NP`, `F`, `Cr` để cân bằng khai thác / thăm dò.
- Tăng `Gmax` nếu muốn hội tụ sâu hơn.
- Giảm `D` để thử nghiệm nhanh, tăng để đánh giá khả năng mở rộng.

## Liên hệ / Báo lỗi

Nếu thấy hàm DE thiếu / lỗi: thêm mã nguồn vào `src/` hoặc yêu cầu triển khai tối ưu hơn. Gửi mô tả lỗi và tham số bạn đã dùng.

