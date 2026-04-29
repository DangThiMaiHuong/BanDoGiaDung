/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

/**
 *
 * @author PC
 */
public class Product {

    private int id;
    private String name, image, description, category;
    private long price;
    private Integer discount_percent;
    private int type;

    public Product() {
    }

    public Product(int id, String name, String image, String description, long price, Integer discount_percent, int type, String category) {
        this.id = id;
        this.name = name;
        this.image = image;
        this.description = description;
        this.price = price;
        this.discount_percent = discount_percent;
        this.type = type;
        this.category = category;
        
    }
    
    public Product(String name, long price, String image, String description, String category, int type, Integer discount_percent) {
        this.name = name;
        this.image = image;
        this.description = description;
        this.price = price;
        this.discount_percent = discount_percent;
        this.type = type;
        this.category = category;
    }
    
    public int getId() {
        return id;
    }

    public String getName() {
        return name;
    }

    public long getPrice() {
        return price;
    }

    public String getImage() {
        return image;
    }

    public String getDescription() {
        return description;
    }

    public Integer getDiscount_percent() {
        return discount_percent;
    }

    public int getType() {
        return type;
    }

    public String getCategory() {
        return category;
    }
    
    public double getFinalPrice() {
        if (discount_percent != null && discount_percent > 0) {
            return price * (100 - discount_percent) / 100.0;
        }
        return price;
    }
}
