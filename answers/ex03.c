/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   ex03.c                                             :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: szapata- <szapata-@student.42.fr>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2024/11/11 11:56:30 by szapata-          #+#    #+#             */
/*   Updated: 2024/11/11 12:00:55 by szapata-         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

int	main(int argc, char **argv)
{
	if (argc > 1)
	{
		argv++;
		while (*argv && **argv)
		{
			if (**argv == '*')
				write(1, "42", 2);
			else
				write(1, *argv, 1);
			(*argv)++;
		}
	}
	write(1, "\n", 1);
	return (0);
}
