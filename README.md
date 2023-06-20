#  Pham Hong Duy Notes

App using SwiftUI, Real time database Firebase

First: create a project in Firebase -> Download file GoogleService-Info và add to project

Create a real-time Database

Install Cocopods: pod 'Firebase/Database', '8.8.0'
    pod install

------ A brief outline of your approach -----
- Trang đầu tiên sẽ là trang bạn tạo username cho chính mình, nó sẽ được lưu lại, sau đó sẽ được kiểm tra vào những lần sau bạn mở App, 
    nếu bạn đã có username thì bạn sẽ được chuyển sang màn hình xem danh sách tất cả các ghi chú bạn đã tạo
- Mỗi một device đều chỉ tạo được một username
- Ở trang notes: bạn có thể mở lên một modal để có thể thêm một ghi chú bao gồm title và content, sau đó ghi chú của bạn sẽ được lưu vào database, 
    bạn có thể xem ghi chú mới được hiển thị khi modal đã được ẩn
- Ở đây bạn cũng sẽ có một modal xem được tất cả các user được lưu trên database

---- Time for project -----
- 11h cho tất cả các tính năng

---- Any known issues or limitations of the solution -----
- Tôi đã phải search khá nhiều cho Firebase config, ví dụ như Rules chuyển sang read = true, write = true, tôi download GoogleService-Info 
    trước khi tạo real time database dẫn đến file này không có URL của database, phần config ở init App, phần child của db,...
- SwiftUI cũng là một khó khăn khi tôi làm project vì tôi không quá quen thuộc với nó nên giao diện bạn có thể nhìn thấy nó khá sơ sài 
    và không được đẹp
