<?php

$finder = (new PhpCsFixer\Finder())
    ->ignoreVCSIgnored(true)
    ->in('test/src');

return (new \PhpCsFixer\Config())
    ->setRiskyAllowed(true)
    ->setRules(
        [
            '@PSR12' => true,
        ]
    )
    ->setFinder($finder);
