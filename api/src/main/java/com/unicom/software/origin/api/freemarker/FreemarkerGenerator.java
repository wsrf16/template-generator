package com.unicom.software.origin.api.freemarker;

import com.aio.portable.swiss.sugar.CollectionSugar;
import com.aio.portable.swiss.suite.bean.serializer.yaml.YamlSugar;
import com.aio.portable.swiss.suite.io.IOFiles;
import com.aio.portable.swiss.suite.io.NIOFiles;
import com.aio.portable.swiss.suite.io.PathSugar;
import freemarker.template.Configuration;
import freemarker.template.Template;
import freemarker.template.TemplateException;
import freemarker.template.TemplateExceptionHandler;
import org.springframework.util.StringUtils;

import java.io.*;
import java.nio.charset.StandardCharsets;
import java.nio.file.Path;
import java.text.MessageFormat;
import java.util.*;

public class FreemarkerGenerator {
    private final static String DELIMITER = "/";
    public final static List<String> EXTENSION_SPECIFIC = Arrays.asList(".yaml", ".yml");
    public String SPECIFIC_DIRECTORY = "specific";
    public String TEMPLATES_DIRECTORY = "templates";
    public String TEMPLATES_FTL_DIRECTORY = "ftl";
    public String TEMPLATES_SPECIFICPARENT_DIRECTORY = "specific";


    private Configuration configuration;
    private String projectRootDirectory;
    private String specificDirectory;
    private String templatesSpecificParentDirectory;
    private String templatesFtlDirectory;



    public FreemarkerGenerator(String projectDirectory) {
        setProjectRootDirectory(projectDirectory);
        buildConfiguration();
    }

    public void setProjectRootDirectory(String projectRootDirectory) {
        this.projectRootDirectory = projectRootDirectory;
        this.specificDirectory = PathSugar.path(projectRootDirectory, SPECIFIC_DIRECTORY);
        this.templatesSpecificParentDirectory = PathSugar.path(projectRootDirectory, TEMPLATES_DIRECTORY, TEMPLATES_SPECIFICPARENT_DIRECTORY);
        this.templatesFtlDirectory = PathSugar.path(projectRootDirectory, TEMPLATES_DIRECTORY, TEMPLATES_FTL_DIRECTORY);
    }

    private void buildConfiguration() {
        configuration = new Configuration(Configuration.DEFAULT_INCOMPATIBLE_IMPROVEMENTS);
        configuration.setTemplateExceptionHandler(TemplateExceptionHandler.DEBUG_HANDLER);
        configuration.setDefaultEncoding(StandardCharsets.UTF_8.name());
        try {
            configuration.setDirectoryForTemplateLoading(new File(templatesFtlDirectory));
        } catch (IOException e) {
            e.printStackTrace();
            throw new RuntimeException(e);
        }
    }

    private final static Map<String, Object> file2Map(String path) {
        Map<String, Object> map = YamlSugar.file2T(path, Map.class);
        Optional<String> anyStartsWithUnderLine = map.keySet().stream().filter(c -> c.startsWith("_")).findAny();
        if (anyStartsWithUnderLine.isPresent())
            throw new RuntimeException(MessageFormat.format("The key \"{0}\" can not start with \"_\" in {1}", anyStartsWithUnderLine.get(), path));
        return map;
    }

    private final static void process(Configuration configuration, String templateName, Object model, File file) {
        try {
            IOFiles.createParentDirectories(file);
            Template template = configuration.getTemplate(templateName);
            template.process(model, new BufferedWriter(new OutputStreamWriter(new FileOutputStream(file))));
        } catch (IOException e) {
            e.printStackTrace();
            throw new RuntimeException(e);
        } catch (TemplateException e) {
            e.printStackTrace();
            throw new RuntimeException(e);
        }
    }

    public void generate() {
        specificFileList(specificDirectory).forEach(path -> {
            String specificUnitPath = path.toString();
            Map<String, Object> specificUnitMap = file2Map(specificUnitPath);

            String specificParentPath = PathSugar.path(templatesSpecificParentDirectory, specificUnitMap.get("specificParent").toString());
            Map<String, Object> specificParentMap = file2Map(specificParentPath);

            ((List<Map<String, Object>>)(specificUnitMap.get("specificList"))).stream().forEach(specificMap -> {
                SpecificHolder.formatSpecific(specificMap);
                System.out.println(specificMap);

//                Map<String, Object> rootMap = new HashMap<>();
//                rootMap.put("_specific", specificMap);
//                rootMap.put("_specificUnit", specificUnitMap);
//                rootMap.put("_specificParent", specificParentMap);

                Map<String, Object> rootMap = CollectionSugar.concatIfAbsent(c -> Objects.nonNull(c.getValue()), specificMap, specificUnitMap, specificParentMap);
                Map<String, Object> _originMap = new HashMap<>();
                _originMap.put("specific", specificMap);
                _originMap.put("specificUnit", specificUnitMap);
                _originMap.put("specificParent", specificParentMap);
                rootMap.put("_origin", _originMap);


                String template = (String) rootMap.get("template");
                String targetLocation = (String) rootMap.get("targetLocation");
                String relativePath = (String) rootMap.get("relativePath");

                if (!specificMap.containsKey("fileName") || !StringUtils.hasText((String)specificMap.get("fileName")))
                    throw new RuntimeException(MessageFormat.format("fileName is null or empty in {0}.", specificUnitPath));
                String fileName = specificMap.get("fileName").toString();
                String targetPath = PathSugar.concatBy(DELIMITER, targetLocation, relativePath, fileName);

                process(configuration, template, rootMap, new File(targetPath));
            });
        });
    }

    private List<Path> specificFileList(String specificPath) {
        return NIOFiles.listChildrenFilePath(specificPath, EXTENSION_SPECIFIC);
    }


}
