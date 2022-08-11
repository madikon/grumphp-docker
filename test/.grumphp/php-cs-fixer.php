<?php

$finder = (new PhpCsFixer\Finder())
    ->ignoreVCSIgnored(true)
    ->in('test/src');

return (new \PhpCsFixer\Config())
    ->setRiskyAllowed(true)
    ->setRules(
        [
            '@DoctrineAnnotation' => true,
            '@PSR12' => true,
            'array_syntax' => ['syntax' => 'short'],
            'concat_space' => ['spacing' => 'one'],
            'dir_constant' => true,
            'function_typehint_space' => true,
            'modernize_types_casting' => true,
            'native_function_casing' => true,
            'no_alias_functions' => true,
            'no_blank_lines_after_phpdoc' => true,
            'no_empty_phpdoc' => true,
            'no_empty_statement' => true,
            'no_extra_blank_lines' => true,
            'no_leading_namespace_whitespace' => true,
            'no_null_property_initialization' => true,
            'no_short_bool_cast' => true,
            'no_singleline_whitespace_before_semicolons' => true,
            'no_superfluous_elseif' => true,
            'no_trailing_comma_in_singleline_array' => true,
            'no_unneeded_control_parentheses' => [
                'statements' => [
                    'break',
                    'clone',
                    'continue',
                    'echo_print',
                    'return',
                    'switch_case',
                ]
            ],
            'no_unused_imports' => true,
            'no_useless_else' => true,
            'ordered_imports' => true,
            'php_unit_construct' => [ 'assertions' => ['assertEquals', 'assertSame', 'assertNotEquals', 'assertNotSame']],
            'php_unit_mock_short_will_return' => true,
            'php_unit_test_case_static_method_calls' => ['call_type' => 'self'],
            'phpdoc_no_access' => true,
            'phpdoc_no_empty_return' => true,
            'phpdoc_no_package' => true,
            'phpdoc_scalar' => true,
            'phpdoc_trim' => true,
            'phpdoc_types' => true,
            'phpdoc_types_order' => ['null_adjustment' => 'always_last', 'sort_algorithm' => 'none'],
            'single_quote' => true,
            'whitespace_after_comma_in_array' => true,
        ]
    )
    ->setFinder($finder);
