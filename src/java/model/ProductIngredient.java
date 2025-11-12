package model;

// Đây là model cho bảng quan hệ N-N (ProductIngredients)
public class ProductIngredient {
    private int productId;
    private int ingredientId;
    private double quantityNeeded;

    public ProductIngredient() {}

    public ProductIngredient(int productId, int ingredientId, double quantityNeeded) {
        this.productId = productId;
        this.ingredientId = ingredientId;
        this.quantityNeeded = quantityNeeded;
    }

    // --- Getters and Setters ---

    public int getProductId() { return productId; }
    public void setProductId(int productId) { this.productId = productId; }
    public int getIngredientId() { return ingredientId; }
    public void setIngredientId(int ingredientId) { this.ingredientId = ingredientId; }
    public double getQuantityNeeded() { return quantityNeeded; }
    public void setQuantityNeeded(double quantityNeeded) { this.quantityNeeded = quantityNeeded; }
}