package jcw.camoServer.repository;

import jcw.camoServer.entity.Cafe;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface CafeRepository extends JpaRepository<Cafe, Long> {
    public Optional<Cafe> findByCafeNameContains(String cafeName);
}