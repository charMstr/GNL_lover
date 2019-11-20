/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   get_next_line_utils.c                              :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: charmstr <marvin@42.fr>                    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2019/11/17 16:02:13 by charmstr          #+#    #+#             */
/*   Updated: 2019/11/18 16:25:18 by charmstr         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "get_next_line.h"

/*
** RETURN: new link initialised and  matching the file descriptor.
*/

t_fd	*new_link(int fd)
{
	t_fd	*new_link;

	if (!(new_link = (t_fd*)malloc(sizeof(*new_link))))
		return (NULL);
	new_link->fd = fd;
	new_link->rest = NULL;
	new_link->len_rest = 0;
	new_link->len_line = 0;
	new_link->eof = 0;
	new_link->next = NULL;
	return (new_link);
}

/*
** note: if add is 0 -> try to remove link containing the matching fd
**
** note2: if add is 1 -> RETURN link containing the matching fd, or created one
*/

t_fd	*manage_link(int fd, t_fd **list, int add)
{
	t_fd	**tracer;
	t_fd	*extra;

	if (!list || (!(*list) && !add))
		return (NULL);
	tracer = list;
	while (*tracer && ((*tracer)->fd != fd))
		tracer = &(*tracer)->next;
	if (*tracer && ((*tracer)->fd == fd) && add)
		return (*tracer);
	else if (*tracer && ((*tracer)->fd == fd) && !add)
	{
		extra = *tracer;
		*tracer = extra->next;
		free(extra->rest);
		free(extra);
	}
	if (add)
		extra = (t_fd*)malloc(sizeof(*extra));
	if (!add || !extra)
		return (NULL);
	return (*tracer = new_link(fd));
}
