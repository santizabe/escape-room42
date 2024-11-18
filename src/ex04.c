/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ex04.c                                             :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: szapata- <szapata-@student.42.fr>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2024/11/11 12:01:09 by szapata-          #+#    #+#             */
/*   Updated: 2024/11/11 12:01:21 by szapata-         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include <unistd.h>

char    get_char(char c)
{
    int i = 0;
    
    if ((c >= 65 && c <= 90) || (c >= 97 && c <= 122))
    {
        while (i < 10)
        {
            c++;
            if (c == 123)
                c = 97;
            else if (c == 91)
                c = 65;
            i++;
        }
    }
    return (c);
}

int main(int argc, char **argv)
{
    char c;
    
    c = 0;
    if (argc > 1)
    {
        argv++;
        while (**argv)
        {
            c = get_char(**argv);
            write(1, &c, 1);
            (*argv)++;
        }
    }    
    write(1, "\n", 1);
    return 0;
}
