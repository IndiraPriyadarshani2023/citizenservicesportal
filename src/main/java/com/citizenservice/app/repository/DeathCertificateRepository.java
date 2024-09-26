package com.citizenservice.app.repository;

//public class deathCertificateRepository {
//
//}
import org.springframework.data.jpa.repository.JpaRepository;

import com.citizenservice.app.model.DeathCertificate;

public interface DeathCertificateRepository extends JpaRepository <DeathCertificate, Long>{
 
}
