# CẤU TRÚC DỰ ÁN

## Mobile

```plaintext
lib/
│
├── features/               # Các module chức năng (chia nhỏ theo tính năng)
├── common/                 # Chứa các thành phần dùng chung
├── i18n/                   # Thư mục quản lý đa ngôn ngữ
├── theme/                  # Thư mục quản lý chủ đề ứng dụng
│
├── animation.dart          # File khởi tạo các hiệu ứng animation
├── main.dart               # File entry point khởi chạy ứng dụng
└── firebase_options.dart   # File cấu hình dịch vụ firebase
```

## Backend

```plaintext
src/
│
├── modules/                # Các module chức năng (chia nhỏ theo tính năng)
├── common/                 # Chứa các thành phần dùng chung
├── database/               # Thư mục quản lý cơ sở dữ liệu
├── providers/              # Thư mục quản lý cấu hình dịch vụ bên thứ 3
│
├── main.ts                 # File entry point cho máy chủ tự quản lý
├── index.ts                # File entry point cho dịch vụ firebase
├── app.module.ts           # Module gốc của ứng dụng
├── app.controller.ts       # Controller gốc (nếu cần)
└── app.service.ts          # Service gốc (nếu cần)
```

## Chi tiết

### Common

```plaintext
common/                 # Chứa các thành phần dùng chung
├── decorators/         # Các decorator tùy chỉnh
│   ├── roles.decorator.ts
├── filters/            # Exception filters dùng chung
│   ├── http-exception.filter.ts
├── interceptors/       # Các interceptor (logging, response mapping,...)
│   ├── logging.interceptor.ts
├── pipes/              # Các pipe (validation, transformation,...)
│   ├── validation.pipe.ts
├── guards/             # Các guard dùng chung
└── utils/              # Tiện ích dùng chung (helper functions)
    ├── date.util.ts
    └── string.util.ts      
```

### Modules

```plaintext
modules/                # Các module chức năng (chia nhỏ theo tính năng)
├── user/               # Ví dụ: Module người dùng
│   ├── controllers/
│   │   ├── user.controller.ts
│   ├── services/
│   │   ├── user.service.ts
│   ├── dto/            # Data Transfer Objects (DTO)
│   │   ├── create-user.dto.ts
│   │   ├── update-user.dto.ts
│   ├── entities/       # Định nghĩa model hoặc schema
│   │   ├── user.entity.ts
│   │── interfaces/     # Các interface liên quan
│   │   ├── user.interface.ts
│   ├── user.module.ts
│   └── index.ts
│
└── auth/               # Ví dụ: Module xác thực
    ├── auth.controller.ts
    ├── auth.service.ts
    ├── auth.module.ts
    ├── guards/         # Các guard liên quan (authentication, authorization)
    │   ├── jwt.guard.ts
    │   └── roles.guard.ts
    ├── strategies/     # Các chiến lược xác thực (JWT, OAuth,...)
    │   ├── jwt.strategy.ts
    │   └── local.strategy.ts
    ├── dto/
    ├── interfaces/
    └── entities/
```

### Database

```plaintext
database/               # Thư mục quản lý cơ sở dữ liệu
├── database.provider.ts     
├── database.module.ts     
└── index.ts   
```

### Providers

```plaintext
providers/               # Thư mục quản lý cấu hình dịch vụ bên thứ 3
├── functions/           # Dịch vụ cloud functions
│   ├── index.ts
├── .../                 # Các dịch vụ khác của firebase
└── index.ts   
```