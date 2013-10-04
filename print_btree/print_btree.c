/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   print_tree.c                                       :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: adu-ranq <marvin@42.fr>                    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2013/08/29 16:45:44 by adu-ranq          #+#    #+#             */
/*   Updated: 2013/08/29 17:37:01 by adu-ranq         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include <stdio.h>

typedef struct	s_btree
{
	struct s_btree	*left;
	struct s_btree	*right;
	void			*item;
}				t_btree;

int		my_pow(int nb, int pow);
void	print_n_char(char c, int nb);
void	print_node(t_btree *node, int prof, int offset);

/*============================================================================*/

void	ft_print_tree(t_btree *root, int prof)
{
	int offset = 0;
	int x = 0;
	while (x < prof - 1)
		offset += my_pow(2, x++);
	x = 0;
	while (x < prof)
	{
		print_n_char(' ', offset);
		print_node(root, x, offset * 2 + 1);
		printf("\n");
		offset /= 2;
		x++;
	}
}

/*============================================================================*/

int		my_pow(int nb, int pow)
{
	int result = 1;
	while (pow-- > 0)
		result *= nb;
	return result;
}

void	print_n_char(char c, int nb)
{
	while (nb-- > 0)
		printf("%c", c);
}

void	print_node(t_btree *node, int prof, int offset)
{
	if (prof == 0)
	{
		if (node != NULL)
		{
			printf("%s", (char*)node->item);
			print_n_char(' ', offset);
		}
		else
			print_n_char(' ', offset + 1);
	}
	else if (node != NULL)
	{
		print_node(node->left, prof - 1, offset);
		print_node(node->right, prof - 1, offset);
	}
}
