package vn.edu.ute.service.impl;

import vn.edu.ute.dao.ISellerDao_24110302;
import vn.edu.ute.dao.impl.SellerDaoImpl_24110302;
import vn.edu.ute.entity.Seller;
import vn.edu.ute.service.ISellerService_24110302;

import java.util.List;

public class SellerServiceImpl_24110302 implements ISellerService_24110302 {

    private final ISellerDao_24110302 sellerDao = new SellerDaoImpl_24110302();

    @Override
    public Seller findById(Long id) {
        return sellerDao.findById(id);
    }

    @Override
    public List<Seller> findAll() {
        return sellerDao.findAll();
    }
}
