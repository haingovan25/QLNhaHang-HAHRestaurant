package model;

public class Ingredient {
    private int id;
    private String name;
    private String unit;
    private double stockQuantity;
    private double reorderLevel;

    public Ingredient() {}

    public Ingredient(int id, String name, String unit, double stockQuantity, double reorderLevel) {
        this.id = id;
        this.name = name;
        this.unit = unit;
        this.stockQuantity = stockQuantity;
        this.reorderLevel = reorderLevel;
    }

    // --- Getters and Setters ---

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    public String getUnit() { return unit; }
    public void setUnit(String unit) { this.unit = unit; }
    public double getStockQuantity() { return stockQuantity; }
    public void setStockQuantity(double stockQuantity) { this.stockQuantity = stockQuantity; }
    public double getReorderLevel() { return reorderLevel; }
    public void setReorderLevel(double reorderLevel) { this.reorderLevel = reorderLevel; }
}