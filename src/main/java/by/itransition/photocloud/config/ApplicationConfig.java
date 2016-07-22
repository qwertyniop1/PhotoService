package by.itransition.photocloud.config;

import org.apache.commons.dbcp.BasicDataSource;
import org.hibernate.SessionFactory;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Import;
import org.springframework.orm.hibernate4.HibernateTransactionManager;
import org.springframework.orm.hibernate4.LocalSessionFactoryBuilder;
import org.springframework.transaction.annotation.EnableTransactionManagement;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.view.InternalResourceViewResolver;

import java.util.Properties;

@EnableWebMvc
@Configuration
@ComponentScan({ "by.itransition.photocloud.*" })
@EnableTransactionManagement
@Import({ SecurityConfig.class })
public class ApplicationConfig {

    @Bean
    public SessionFactory sessionFactory() {
        LocalSessionFactoryBuilder builder = new LocalSessionFactoryBuilder(dataSource());
        builder.scanPackages("by.itransition.photocloud.auth.model").addProperties(getHibernateProperties());
        return builder.buildSessionFactory();
    }

    private Properties getHibernateProperties() {
        Properties properties = new Properties();
        properties.put("hibernate.format_sql", "true");
        properties.put("hibernate.show_sql", "true");
        properties.put("hibernate.dialect",
                "org.hibernate.dialect.MySQL5Dialect");
        return properties;
    }

    @Bean
    public BasicDataSource dataSource() {
        BasicDataSource dataSource = new BasicDataSource();
        dataSource.setDriverClassName("com.mysql.jdbc.Driver");
        dataSource.setUrl("jdbc:mysql://localhost:3306/auth");
        dataSource.setUsername("hbstudent");
        dataSource.setPassword("hbstudent");

        return dataSource;
    }

    @Bean
    public HibernateTransactionManager transactionManager() {
        return  new HibernateTransactionManager(sessionFactory());
    }

    @Bean
    public InternalResourceViewResolver viewResolver() {
        InternalResourceViewResolver viewResolver = new InternalResourceViewResolver();
        // viewResolver.setViewClass(JstlView.class);
        viewResolver.setPrefix("/WEB-INF/view/");
        viewResolver.setSuffix(".jsp");
        return viewResolver;
    }

}
