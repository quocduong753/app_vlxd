package com.example.vatlieuxaydung.exeption;

public enum ErrorCode {
    INVALID_INPUT(1001, "Invalid input data"),
    RESOURCE_NOT_FOUND(1002, "Resource not found"),
    ACCESS_DENIED(1003, "Access denied"),
    DATABASE_ERROR(1004, "Database operation failed"),
    UNCATEGORIZED_EXCEPTION(1005, "Uncategorized error"),
    INVALID_KEY(1006,"Invalid message key"),
    UNAUTHORIZED(1007, "Unauthorized"),
    TOKEN_EXPIRED(1008, "Token expired"),
    INVALID_TOKEN(1009, "Invalid token"),

    CATEGORY_ALREADY_EXISTS(3001, "Category already exists"),
    CATEGORY_CONTAINS_PRODUCTS(2003, "Category contains products and cannot be deleted"),

    VATTU_ALREADY_EXISTS(3001, "VatTu already exists"),
    VATTU_LINKED_TO_ORDERS(3002, "VatTu is linked to existing orders and cannot be deleted"),
    VATTU_UPDATE_FAILED(3003, "Failed to update VatTu"),
    VATTU_DELETE_FAILED(3004, "Failed to delete VatTu due to dependencies"),

    INVALID_VATTU_CODE(3101, "Invalid VatTu code format"),
    INVALID_VATTU_PRICE(3102, "Invalid price for VatTu"),
    INVALID_VATTU_DESCRIPTION(3103, "Invalid description for VatTu"),
    INVALID_CATEGORY_FOR_VATTU(3104, "Invalid category assigned to VatTu"),

    USERNAME_ALREADY_EXISTS(4001, "Username already exists"),
    USERNAME_INVALID(4002, "Username must be at least 2 characters"),
    PASSWORD_INVALID(4003,"Password must be at least 6 characters"),
    EMAIL_INVALID(4004,"Email invalid"),
    USERNAME_NOT_FOUND(4005, "Username does not exist"),
    PASSWORD_INCORRECT(4006, "Password is incorrect"),
    PASSWORD_NOT_SAME(4007,"passwords can't be the same");


    ;
    private int code;
    private String message;

    ErrorCode(int code, String message) {
        this.code = code;
        this.message = message;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public int getCode() {
        return code;
    }

    public void setCode(int code) {
        this.code = code;
    }
}
