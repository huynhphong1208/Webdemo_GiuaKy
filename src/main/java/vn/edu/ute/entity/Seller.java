package vn.edu.ute.entity;

import jakarta.persistence.*;
import java.io.Serializable;

@Entity
@Table(name = "Seller")
public class Seller implements Serializable {
    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "sellerId")
    private Long sellerId;

    @Column(name = "sellerName", nullable = false, length = 200)
    private String sellerName;

    @Column(name = "images", length = 500)
    private String images;

    @Column(name = "status")
    private Integer status;

    public Seller() {}

    public Seller(Long sellerId, String sellerName, String images, Integer status) {
        this.sellerId = sellerId;
        this.sellerName = sellerName;
        this.images = images;
        this.status = status;
    }

    public Long getSellerId() {
        return sellerId;
    }

    public void setSellerId(Long sellerId) {
        this.sellerId = sellerId;
    }

    public String getSellerName() {
        return sellerName;
    }

    public void setSellerName(String sellerName) {
        this.sellerName = sellerName;
    }

    public String getImages() {
        return images;
    }

    public void setImages(String images) {
        this.images = images;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }
}
