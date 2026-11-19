package vn.iotstar.config;

import java.net.URL;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import javax.sql.DataSource;

import org.hibernate.jpa.HibernatePersistenceProvider;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.SharedCacheMode;
import jakarta.persistence.ValidationMode;
import jakarta.persistence.spi.ClassTransformer;
import jakarta.persistence.spi.PersistenceUnitInfo;
import jakarta.persistence.spi.PersistenceUnitTransactionType;
import vn.iotstar.entity.Category;
import vn.iotstar.entity.User;
import vn.iotstar.entity.Video;

public class JpaConfig {

    private static final EntityManagerFactory FACTORY;

    static {
        try {
            Map<String, Object> properties = new HashMap<>();
            properties.put("jakarta.persistence.jdbc.driver", "com.microsoft.sqlserver.jdbc.SQLServerDriver");
            properties.put("jakarta.persistence.jdbc.url", "jdbc:sqlserver://localhost:1433;encrypt=true;trustServerCertificate=true;databaseName=JPA_Category");
            properties.put("jakarta.persistence.jdbc.user", "sa");
            properties.put("jakarta.persistence.jdbc.password", "1234@a$");

            properties.put("hibernate.show_sql", "true");
            properties.put("hibernate.format_sql", "true");
            properties.put("hibernate.hbm2ddl.auto", "update");
            properties.put("hibernate.dialect", "org.hibernate.dialect.SQLServerDialect");

            PersistenceUnitInfo pui = new PersistenceUnitInfo() {
                @Override
                public String getPersistenceUnitName() {
                    return "jpa-hibernate-sqlserver";
                }

                @Override
                public String getPersistenceProviderClassName() {
                    return HibernatePersistenceProvider.class.getName();
                }

                @Override
                public PersistenceUnitTransactionType getTransactionType() {
                    return PersistenceUnitTransactionType.RESOURCE_LOCAL;
                }

                @Override
                public DataSource getJtaDataSource() {
                    return null;
                }

                @Override
                public DataSource getNonJtaDataSource() {
                    return null;
                }

                @Override
                public List<String> getMappingFileNames() {
                    return Collections.emptyList();
                }

                @Override
                public List<URL> getJarFileUrls() {
                    return Collections.emptyList();
                }

                @Override
                public URL getPersistenceUnitRootUrl() {
                    return null;
                }

                @Override
                public List<String> getManagedClassNames() {
                    return List.of(
                        Category.class.getName(),
                        Video.class.getName(),
                        User.class.getName()
                    );
                }

                @Override
                public boolean excludeUnlistedClasses() {
                    return true;
                }

                @Override
                public SharedCacheMode getSharedCacheMode() {
                    return SharedCacheMode.UNSPECIFIED;
                }

                @Override
                public ValidationMode getValidationMode() {
                    return ValidationMode.AUTO;
                }

                @Override
                public Properties getProperties() {
                    Properties props = new Properties();
                    props.putAll(properties);
                    return props;
                }

                @Override
                public String getPersistenceXMLSchemaVersion() {
                    return "3.0";
                }

                @Override
                public ClassLoader getClassLoader() {
                    return Thread.currentThread().getContextClassLoader();
                }

                @Override
                public void addTransformer(ClassTransformer transformer) {
                }

                @Override
                public ClassLoader getNewTempClassLoader() {
                    return null;
                }
            };

            FACTORY = new HibernatePersistenceProvider()
                    .createContainerEntityManagerFactory(pui, properties);

        } catch (Throwable ex) {
            System.err.println("LỖI KHỞI TẠO JPA / HIBERNATE: " + ex.getMessage());
            ex.printStackTrace();
            throw new ExceptionInInitializerError(ex);
        }
    }

    public static EntityManager getEntityManager() {
        return FACTORY.createEntityManager();
    }

    public static void close() {
        if (FACTORY != null && FACTORY.isOpen()) {
            FACTORY.close();
        }
    }
}
