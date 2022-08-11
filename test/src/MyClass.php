<?php

declare(strict_types=1);

namespace Madikon;

/**
 * Class MyClass
 */
class MyClass
{
    private string $variable = '';

    /**
     * @param string $value
     *
     * @return MyClass
     */
    public function setVariable(string $value): MyClass
    {
        $this->variable = $value;

        return $this;
    }

    /**
     * @return string $vvariable
     */
    public function getVariable(): string
    {
        return $this->variable;
    }
}
